class AppString {
  // label text
  static const String pan = "PAN";
  static const String fullName = "Full Name";
  static const String email = "Email";
  static const String mobileNumber = "Mobile Number";
  static const String addressLine1 = "Address Line 1";
  static const String addressLine2 = "Address Line 2";
  static const String city = "City";
  static const String state = "State";
  static const String postcode = "Postcode";
  static const String addAddress = "Add Address";
  static const String saveCustomer = "Save Customer";
  static const String cancel = "Cancel";
  static const String delete = "Delete";
  static const String edit = "Edit";
  static const String save = "Save";
  static const String deleteCustomer = "Delete Customer";
  static const String addMoreAddress = "Add More Address";
  static const String close = "Close";


  // message text
  static const String deleteCustomerMessage = "Are you sure you want to delete";
  static const String deleteAddress = "Delete Address";
  static const String deleteAddressMessage =
      "Are you sure you want to delete this address?";
  static const String customerDetails = "Customer Details";
  static const String addresses = "Addresses";
  static const String customerSaved = "Customer saved successfully";

  // validation warnings

  static const String invalidPan = "Invalid PAN number";
  static const String enterPan = "Enter PAN number";
  static const String panWarning = "PAN should be 10 characters long";
  static const String fullNameWarning = "Full Name is required";
  static const String fullNameLengthWarning =
      "Full name should not exceed 140 characters";
  static const String emailRequired = 'Please enter email';
  static const String emailLengthWarning =
      "Email should not exceed 255 characters";
  static const String emailWarning = "Invalid email address";
  static const String mobileWarning =
      "Mobile number should be 10 characters long";
  static const String mobileRequired = "Mobile number is required";

  static const String addressLine1Warning = "Address Line 1 is required";
  static const String cityWarning = "City is required";
  static const String stateWarning = "State is required";
  static const String postcodeWarning = "Postcode is required";
  static const String invalidPostcodeWarning = "Postcode should be 6 digits";
}
