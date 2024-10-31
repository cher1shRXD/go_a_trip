import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetToken {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> setAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  static Future<void> setRefreshToken(String token) async {
    await _storage.write(key: 'refreshToken', value:token);
  }
}
