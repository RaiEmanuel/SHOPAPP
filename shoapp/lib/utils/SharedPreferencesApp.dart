import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyType = 'type';
  static const _keyToken = 'token';

  static Future setType(String type) async =>
      await _storage.write(key: _keyType, value: type);

  static Future<String> getType() async =>
      await _storage.read(key: _keyType) ?? "Type void";

  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String> getToken() async =>
      await _storage.read(key: _keyToken) ?? "Token void";
}