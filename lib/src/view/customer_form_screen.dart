import 'package:customer_management/controller/address_controller.dart';
import 'package:customer_management/controller/customer_controller.dart';
import 'package:customer_management/model/customer_model.dart';
import 'package:customer_management/src/view/widgets/address_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CustomerFormPage extends StatefulWidget {
  final Customer? customer;
  final int? index;

  CustomerFormPage({this.customer, this.index});

  @override
  _CustomerFormPageState createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final CustomerController customerController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final panController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressControllers = List.generate(10, (_) => AddressController());

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      panController.text = widget.customer!.pan;
      fullNameController.text = widget.customer!.fullName;
      emailController.text = widget.customer!.email;
      mobileNumberController.text = widget.customer!.mobileNumber;
      for (int i = 0; i < widget.customer!.addresses.length; i++) {
        addressControllers[i].populate(widget.customer!.addresses[i]);
      }
    }
  }

  @override
  void dispose() {
    panController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    //addressControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer != null ? 'Edit Customer' : 'Add Customer'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(

          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: panController,
              decoration: InputDecoration(labelText: 'PAN'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter PAN';
                }
                // Add PAN format validation here
                return null;
              },
              onChanged: (value) async {
                if (value.length == 10) {
                  final response = await customerController.verifyPAN(value);
                  if (response['isValid']) {
                    fullNameController.text = response['fullName'];
                  }
                }
              },
            ),
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter full name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: mobileNumberController,
              decoration: InputDecoration(labelText: 'Mobile Number', prefixText: '+91 '),
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 10) {
                  return 'Please enter valid mobile number';
                }
                return null;
              },
            ),
            for (int i = 0; i < 10; i++) AddressFormField(controller: addressControllers[i]),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final customer = Customer(
                    pan: panController.text,
                    fullName: fullNameController.text,
                    email: emailController.text,
                    mobileNumber: mobileNumberController.text,
                    addresses: addressControllers
                        .where((controller) => controller.isNotEmpty)
                        .map((controller) => controller.toAddress())
                        .toList(),
                  );

                  if (widget.customer != null) {
                    customerController.editCustomer(widget.index!, customer);
                  } else {
                    customerController.addCustomer(customer);
                  }

                  Get.back();
                }
              },
              child: Text(widget.customer != null ? 'Update Customer' : 'Add Customer'),
            ),
          ],
        ),
      ),
    );
  }
}