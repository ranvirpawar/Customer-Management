// services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://lab.pixel6.co/api'));

  Future<Map<String, dynamic>> verifyPAN(String panNumber) async {
    print('panNumber: $panNumber');
    final response =
        await _dio.post('/verify-pan.php', data: {'panNumber': panNumber});
    print('response: ${response.data}');
    return response.data;
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    final response = await _dio
        .post('/get-postcode-details.php', data: {'postcode': postcode});
    return response.data;
  }
}
