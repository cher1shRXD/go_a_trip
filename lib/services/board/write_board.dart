import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/services/auth/get_token.dart';
import 'package:go_a_trip/services/auth/refresh_token.dart';
import 'package:go_a_trip/services/common/base_url.dart';
import 'package:go_a_trip/services/common/http_exception.dart';
import 'package:http/http.dart' as http;

class WriteBoardService {
  Future<void> writeRequest(String title, String detail) async {
    final NavigateController controller = Get.find<NavigateController>();
    String? accessToken = await GetToken.getAccessToken();

    try {
      final url = Uri.parse('$baseUrl/boards');
      final body =
          jsonEncode({'title': title, 'detail': detail, 'category': 'FREE'});

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        controller.selectedIndex.value = 0;
      } else if (response.statusCode == 401) {
        await RefreshToken().refreshRequest();
        accessToken = await GetToken.getAccessToken();
        return writeRequest(title, detail);
      } else {
        throw HttpException(
            'Failed to write post. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error writing post: $e');
      throw HttpException('Error writing post: $e');
    }
  }
}
