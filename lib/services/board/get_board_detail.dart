import 'dart:convert';
import 'dart:developer';

import 'package:go_a_trip/models/board_model.dart';
import 'package:go_a_trip/services/common/base_url.dart';
import 'package:go_a_trip/services/common/http_exception.dart';
import 'package:http/http.dart' as http;

class GetBoardDetailService {
  Future<Board> boardDetailRequest(int id) async {
    try {
      final url = Uri.parse('$baseUrl/boards/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final Board decodedData = Board.fromJson(jsonData);
        return decodedData;
      } else {
        throw HttpException('Failed to login. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error logging in: $e');
      rethrow;
    }
  }
}
