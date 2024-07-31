import 'package:customer_management/constants/text_strings.dart';
import 'package:customer_management/controller/customer_controller.dart';
import 'package:customer_management/model/address_model.dart';
import 'package:customer_management/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomerFormScreen extends StatefulWidget {
  final Customer? customer;
  final int? index;

  const CustomerFormScreen({Key? key, this.customer, this.index})
      : super(key: key);

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final CustomerController customerController = Get.put(CustomerController());
  final _formKey = GlobalKey<FormState>();
  final panController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final List<AddressForm> addresses = [];

  bool isLoading = false;
  bool isPanValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      // Load customer data for editing
      panController.text = widget.customer!.pan;
      fullNameController.text = widget.customer!.fullName;
      emailController.text = widget.customer!.email;
      mobileNumberController.text = widget.customer!.mobileNumber;
      addresses.addAll(widget.customer!.addresses.map((addr) => AddressForm(
            addressLine1Controller:
                TextEditingController(text: addr.addressLine1),
            addressLine2Controller:
                TextEditingController(text: addr.addressLine2),
            postcodeController:
                TextEditingController(text: addr.postcode.toString()),
            stateController: TextEditingController(text: addr.state),
            cityController: TextEditingController(text: addr.city),
          )));
    }
    if (addresses.isEmpty) {
      addresses.add(AddressForm());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // pan card
              SizedBox(height: 8),
              TextFormField(
                controller: panController,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'PAN',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : isPanValid
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.enterPan;
                  }
                  if (value.length != 10) {
                    return AppString.panWarning;
                  }
                  if (!isPanValid) {
                    return AppString.invalidPan;
                  }
                  return null;
                },
                onChanged: (value) async {
                  if (value.length == 10) {
                    setState(() => isLoading = true);
                    final response = await customerController.verifyPAN(value);
                    setState(() {
                      isLoading = false;
                      isPanValid = response['isValid'] ?? false;
                    });
                    if (isPanValid) {
                      fullNameController.text = response['fullName'] ?? '';
                    }
                  } else {
                    setState(() => isPanValid = false);
                  }
                },
              ),
              // full name
              TextFormField(
                controller: fullNameController,
                maxLength: 140,
                decoration:
                    const InputDecoration(labelText: AppString.fullName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.fullNameWarning;
                  }
                  if (value.length > 140) {
                    return AppString.fullNameLengthWarning;
                  }
                  return null;
                },
              ),
              // email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: AppString.email),
                maxLength: 255,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.emailRequired;
                  }
                  if (value.length > 255) {
                    return AppString.emailLengthWarning;
                  }
                  if (!GetUtils.isEmail(value)) {
                    return AppString.emailWarning;
                  }
                  return null;
                },
              ),
              // mobile number
              TextFormField(
                controller: mobileNumberController,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: AppString.mobileNumber,
                  prefixText: '+91  ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppString.emailRequired;
                  }
                  if (value.length != 10) {
                    return AppString.mobileWarning;
                  }
                  if (!GetUtils.isPhoneNumber(value)) {
                    return AppString.mobileWarning;
                  }
                  return null;
                },
              ),

              const Row(
                children: [
                  Text(
                    AppString.addAddress,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              ...addresses.map((address) => address).toList(),
              if (addresses.length < 10)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          addresses.add(AddressForm());
                        });
                      },
                      child: const Text(AppString.addMoreAddress),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final customer = Customer(
                      pan: panController.text,
                      fullName: fullNameController.text,
                      email: emailController.text,
                      mobileNumber: mobileNumberController.text,
                      addresses:
                          addresses.map((addr) => addr.toAddress()).toList(),
                    );
                    if (widget.customer == null) {
                      customerController.addCustomer(customer);
                    } else {
                      customerController.editCustomer(widget.index!, customer);
                    }

                    // Show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppString.customerSaved)),
                    );

                    // clearing all the fields
                    panController.clear();
                    fullNameController.clear();
                    emailController.clear();
                    mobileNumberController.clear();
                    setState(() {
                      addresses.clear();
                      addresses.add(AddressForm());
                    });
                    _formKey.currentState!.reset();
                  }
                },
                child: Text(AppString.saveCustomer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressForm extends StatefulWidget {
  final TextEditingController addressLine1Controller;
  final TextEditingController addressLine2Controller;
  final TextEditingController postcodeController;
  final TextEditingController stateController;
  final TextEditingController cityController;

  AddressForm({
    Key? key,
    TextEditingController? addressLine1Controller,
    TextEditingController? addressLine2Controller,
    TextEditingController? postcodeController,
    TextEditingController? stateController,
    TextEditingController? cityController,
  })  : addressLine1Controller =
            addressLine1Controller ?? TextEditingController(),
        addressLine2Controller =
            addressLine2Controller ?? TextEditingController(),
        postcodeController = postcodeController ?? TextEditingController(),
        stateController = stateController ?? TextEditingController(),
        cityController = cityController ?? TextEditingController(),
        super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();

  Address toAddress() {
    return Address(
      addressLine1: addressLine1Controller.text,
      addressLine2: addressLine2Controller.text,
      postcode: int.parse(postcodeController.text),
      state: stateController.text,
      city: cityController.text,
    );
  }
}

class _AddressFormState extends State<AddressForm> {
  final CustomerController customerController = Get.find<CustomerController>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.addressLine1Controller,
          decoration: InputDecoration(labelText: AppString.addressLine1),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.addressLine1Warning;
            }
            return null;
          },
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.addressLine2Controller,
          decoration: InputDecoration(labelText: AppString.addressLine2),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.postcodeController,
          decoration: InputDecoration(
            labelText: AppString.postcode,
            suffixIcon: isLoading ? CircularProgressIndicator() : null,
          ),
          textInputAction: TextInputAction.done,
          maxLength: 6,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.postcodeWarning;
            }
            if (value.length != 6 || !GetUtils.isNumericOnly(value)) {
              return AppString.invalidPostcodeWarning;
            }
            return null;
          },
          onChanged: (value) async {
            if (value.length == 6 && GetUtils.isNumericOnly(value)) {
              setState(() => isLoading = true);
              final response =
                  await customerController.getPostcodeDetails(value);
              setState(() => isLoading = false);
              if (response['status'] == 'Success') {
                widget.stateController.text = response['state'][0]['name'];
                widget.cityController.text = response['city'][0]['name'];
              }
            }
          },
        ),
        TextFormField(
          controller: widget.stateController,
          decoration: InputDecoration(labelText: AppString.state),
          readOnly: true,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.cityController,
          decoration: InputDecoration(labelText: AppString.city),
          readOnly: true,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
