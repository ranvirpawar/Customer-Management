import 'package:flutter/material.dart';

import '../../../controller/address_controller.dart';

class AddressFormField extends StatelessWidget {
  final AddressController controller;

  AddressFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller.addressLine1,
          decoration: InputDecoration(labelText: 'Address Line 1'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter address line 1';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.addressLine2,
          decoration: InputDecoration(labelText: 'Address Line 2'),
        ),
        TextFormField(
          controller: controller.postcode,
          decoration: InputDecoration(labelText: 'Postcode'),
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 6) {
              return 'Please enter valid postcode';
            }
            return null;
          },
          onChanged: (value) async {
            if (value.length == 6) {
              final response = await controller.getPostcodeDetails(value);
              controller.state.text = response['state'][0]['name'];
              controller.city.text = response['city'][0]['name'];
            }
          },
        ),
        TextFormField(
          controller: controller.state,
          decoration: InputDecoration(labelText: 'State'),
          readOnly: true,
        ),
        TextFormField(
          controller: controller.city,
          decoration: InputDecoration(labelText: 'City'),
          readOnly: true,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}