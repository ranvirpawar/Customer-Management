//list of customer
//add, delete edit customer

import 'package:customer_management/controller/customer_controller.dart';
import 'package:customer_management/src/view/customer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerListPage extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: customerController.customers.length,
          itemBuilder: (context, index) {
            final customer = customerController.customers[index];
            return ListTile(
              title: Text(customer.fullName),
              subtitle: Text(customer.pan),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() =>
                          CustomerFormPage(customer: customer, index: index));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      customerController.deleteCustomer(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CustomerFormPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
