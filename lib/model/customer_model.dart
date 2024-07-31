// models/customer.dart
import 'package:customer_management/model/address_model.dart';


class Customer {
  String pan;
  String fullName;
  String email;
  String mobileNumber;
  List<Address> addresses;

  Customer({
    required this.pan,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.addresses,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      pan: json['pan'],
      fullName: json['fullName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      addresses: (json['addresses'] as List)
          .map((address) => Address.fromJson(address))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pan': pan,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }
}
