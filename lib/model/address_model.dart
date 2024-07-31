
// models/address.dart
class Address {
  String addressLine1;
  String? addressLine2;
  int postcode;
  String state;
  String city;

  Address({
    required this.addressLine1,
    this.addressLine2,
    required this.postcode,
    required this.state,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      postcode: json['postcode'],
      state: json['state'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'postcode': postcode,
      'state': state,
      'city': city,
    };
  }
}
