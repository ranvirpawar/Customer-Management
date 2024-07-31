import 'package:customer_management/model/address_model.dart';
import 'package:customer_management/service/api_service.dart';
import 'package:flutter/material.dart';


class AddressController {
  final addressLine1 = TextEditingController();
  final addressLine2 = TextEditingController();
  final postcode = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();

  bool get isNotEmpty => addressLine1.text.isNotEmpty && postcode.text.isNotEmpty;

  void populate(Address address) {
    addressLine1.text = address.addressLine1;
    addressLine2.text = address.addressLine2 ?? '';
    postcode.text = address.postcode as String;
    state.text = address.state;
    city.text = address.city;
  }

  Address toAddress() {
    return Address(
      addressLine1: addressLine1.text,
      addressLine2: addressLine2.text,
      postcode: postcode.text as int,
      state: state.text,
      city: city.text,
    );
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    final response = await ApiService().getPostcodeDetails(postcode);
    return response;
  }
}