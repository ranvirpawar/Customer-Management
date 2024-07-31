import 'package:customer_management/constants/text_strings.dart';
import 'package:customer_management/controller/customer_controller.dart';
import 'package:customer_management/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
          keyboardType: TextInputType.number,
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
