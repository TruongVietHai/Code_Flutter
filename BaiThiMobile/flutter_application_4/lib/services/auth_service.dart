import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _emailKey = 'saved_email';
  static const String _passwordKey = 'saved_password';
  static const String _rememberMeKey = 'remember_me';
  static const String _registeredEmailKey = 'registered_email';
  static const String _registeredPasswordKey = 'registered_password';

  // Lưu tài khoản đã đăng ký
  static Future<void> saveRegisteredAccount({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registeredEmailKey, email);
    await prefs.setString(_registeredPasswordKey, base64Encode(utf8.encode(password)));
  }

  // Lấy tài khoản đã đăng ký
  static Future<Map<String, dynamic>?> getRegisteredAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_registeredEmailKey);
    final password = prefs.getString(_registeredPasswordKey);

    if (email != null && password != null) {
      try {
        return {
          'email': email,
          'password': utf8.decode(base64Decode(password)),
        };
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Lưu thông tin đăng nhập
  static Future<void> saveCredentials({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, base64Encode(utf8.encode(password)));
    await prefs.setBool(_rememberMeKey, rememberMe);
  }

  // Lấy thông tin đăng nhập đã lưu
  static Future<Map<String, dynamic>?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey);
    final password = prefs.getString(_passwordKey);
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;

    if (email != null && password != null && rememberMe) {
      try {
        return {
          'email': email,
          'password': utf8.decode(base64Decode(password)),
          'rememberMe': rememberMe,
        };
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Xóa thông tin đăng nhập
  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.remove(_rememberMeKey);
  }

  // Kiểm tra xem có saved credentials không
  static Future<bool> hasCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }
}
