import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://10.0.2.2:8000/api/auth";

class AuthService {
  /// **📌 Đăng ký tài khoản**
  static Future<Map<String, dynamic>> register(String username, String email, String password) async {
    try {
      final requestBody = jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'password2': password,  // ✅ Django yêu cầu password2
      });

      final response = await http.post(
        Uri.parse("$baseUrl/register/"),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {"success": true, "message": "Đăng ký thành công!"};
      } else {
        return {"success": false, "message": data["password2"][0] ?? "Đăng ký thất bại!"};
      }
    } catch (e) {
      return {"success": false, "message": "Lỗi kết nối: $e"};
    }
  }

  /// **📌 Đăng nhập tài khoản**
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final requestBody = jsonEncode({
        'username': username,
        'password': password,
      });

      final response = await http.post(
        Uri.parse("$baseUrl/login/"),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await saveToken(data["access"]); // ✅ Lưu Token khi đăng nhập thành công
        return {
          "success": true,
          "message": "Đăng nhập thành công!",
          "access": data["access"],
          "refresh": data["refresh"],
          "username": data["username"],
        };
      } else {
        return {"success": false, "message": "Sai tài khoản hoặc mật khẩu!"};
      }
    } catch (e) {
      return {"success": false, "message": "Lỗi kết nối: $e"};
    }
  }

  /// **📌 Lưu Token**
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// **📌 Lấy Token**
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// **📌 Xóa Token**
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// **📌 Đăng xuất**
  static Future<void> logout() async {
    await clearToken(); // ✅ Xóa token khi đăng xuất
  }
}
