import 'package:customer_management/constants/text_strings.dart';
import 'package:customer_management/controller/customer_controller.dart';
import 'package:customer_management/model/customer_model.dart';
import 'package:customer_management/view/customer_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerListScreen extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());

  /*
  appBar: AppBar(
        title: const ,
      ),
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Management'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            if (customerController.customers.isEmpty) {
              return Center(
                child: Text('No customers found.'),
              );
            } else {
              return ListView.builder(
                itemCount: customerController.customers.length,
                itemBuilder: (context, index) {
                  final customer = customerController.customers[index];
                  return CustomerListTile(customer: customer, index: index);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomerListTile extends StatelessWidget {
  final Customer customer;
  final int index;

  CustomerListTile({required this.customer, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(customer.fullName),
        subtitle: Text(customer.email),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Get.to(
                  () => CustomerFormScreen(customer: customer, index: index)),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _showDeleteConfirmationDialog(context),
            ),
          ],
        ),
        onTap: () => _showCustomerDetails(context),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppString.deleteCustomer),
          content:
              Text('Are you sure you want to delete ${customer.fullName}?'),
          actions: <Widget>[
            TextButton(
              child: Text(AppString.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(AppString.delete),
              onPressed: () {
                Get.find<CustomerController>().deleteCustomer(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCustomerDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(customer.fullName),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('PAN: ${customer.pan}'),
                Text('Email: ${customer.email}'),
                Text('Mobile: +91 ${customer.mobileNumber}'),
                SizedBox(height: 16),
                Text('Addresses:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...customer.addresses.map((address) => Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(address.addressLine1),
                          if (address.addressLine2 != null &&
                              address.addressLine2!.isNotEmpty)
                            Text(address.addressLine2!),
                          Text(
                              '${address.city}, ${address.state} - ${address.postcode}'),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppString.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
