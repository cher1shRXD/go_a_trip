import 'dart:convert';
import 'dart:developer';
import 'package:go_a_trip/models/login_model.dart';
import 'package:go_a_trip/services/auth/get_token.dart';
import 'package:go_a_trip/services/auth/set_token.dart';
import 'package:go_a_trip/services/common/base_url.dart';
import 'package:go_a_trip/services/common/http_exception.dart';
import 'package:http/http.dart' as http;

class RefreshToken {
  Future<void> refreshRequest() async {
    String? refreshToken = await GetToken.getRefreshToken();

    try {
      final url = Uri.parse('$baseUrl/auth/refresh');
      final body = jsonEncode({'refreshToken': refreshToken});
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        final decodedData = LoginResponse.fromJson(responseData);
        log(response.body);
        await SetToken.setAccessToken(decodedData.accessToken);
        await SetToken.setRefreshToken(decodedData.refreshToken);
      } else {
        throw HttpException(
            'Failed to refresh. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error logging in: $e');
      rethrow;
    }
  }
}