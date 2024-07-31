// controllers/customer_controller.dart
import 'dart:convert';

import 'package:customer_management/model/customer_model.dart';
import 'package:customer_management/service/api_service.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomerController extends GetxController {
  final ApiService _apiService = ApiService();
  var customers = <Customer>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  Future<void> addCustomer(Customer customer) async {
    customers.add(customer);
    saveCustomers();
  }

  Future<void> editCustomer(int index, Customer customer) async {
    customers[index] = customer;
    saveCustomers();
  }

  Future<void> deleteCustomer(int index) async {
    customers.removeAt(index);
    saveCustomers();
  }

  Future<Map<String, dynamic>> verifyPAN(String panNumber) async {
    return await _apiService.verifyPAN(panNumber);
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    return await _apiService.getPostcodeDetails(postcode);
  }

  Future<void> saveCustomers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> customerList = customers.map((customer) => jsonEncode(customer.toJson())).toList();
    await prefs.setStringList('customers', customerList);
  }

  Future<void> loadCustomers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? customerList = prefs.getStringList('customers');
    if (customerList != null) {
      customers.value = customerList.map((customer) => Customer.fromJson(jsonDecode(customer))).toList();
    }
  }
}