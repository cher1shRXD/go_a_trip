import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetToken {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }
}
