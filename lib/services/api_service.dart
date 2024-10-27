import 'dart:developer';
import 'dart:convert';
import 'package:go_a_trip/models/board_model.dart';
import 'package:go_a_trip/services/common/http_exception.dart';
import 'package:http/http.dart' as http;

class BoardService {
  static const String baseUrl = 'https://gaon.cher1shrxd.me';

  Future<List<Board>> getBoards() async {
    try {
      final url = Uri.parse('$baseUrl/boards');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<Board> decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        throw HttpException(
            'Failed to load boards. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching boards: $e');
      rethrow;
    }
  }
}
