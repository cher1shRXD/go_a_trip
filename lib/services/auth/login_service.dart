import 'dart:convert';
import 'dart:developer';
import 'package:go_a_trip/models/login_model.dart';
import 'package:go_a_trip/services/common/base_url.dart';
import 'package:go_a_trip/services/common/http_exception.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponse> loginRequest(String id, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final body = jsonEncode({'username': id, 'password': password});
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedData = jsonDecode(response.body);
        log(response.body);
        return LoginResponse.fromJson(decodedData);
      } else {
        throw HttpException('Failed to login. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error logging in: $e');
      rethrow;
    }
  }
}
