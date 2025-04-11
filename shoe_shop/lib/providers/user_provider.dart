import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoe_shop/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  String _name = "Người dùng";
  String _email = "example@gmail.com";
  String _phone = "0123456789";
  String _address = "Chưa có địa chỉ";
  int _age = 18;
  bool _isLoggedIn = false; // ✅ Trạng thái đăng nhập

  // **📌 Getter**
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  int get age => _age;
  bool get isLoggedIn => _isLoggedIn; // ✅ Getter mới

  /// **📡 Lấy thông tin người dùng từ API**
  Future<void> fetchUserInfo() async {
    try {
      String? token = await AuthService.getToken();
      if (token == null) return;

      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/auth/user/"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _name = data["username"] ?? _name;
        _email = data["email"] ?? _email;
        _phone = data["phone"] ?? _phone;
        _address = data["address"] ?? _address;
        _age = data["age"] ?? _age;
        _isLoggedIn = true; // ✅ Đánh dấu là đã đăng nhập

        notifyListeners();
      } else {
        debugPrint("❌ Lỗi lấy thông tin người dùng: ${response.body}");
      }
    } catch (e) {
      debugPrint("⚠️ Lỗi fetchUserInfo: $e");
    }
  }

  /// **✏️ Cập nhật thông tin người dùng**
  Future<bool> updateUserInfo({
    required String name,
    String? password,
    required String phone,
    required String address,
    required int age,
  }) async {
    try {
      String? token = await AuthService.getToken();
      if (token == null) return false;

      final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/auth/user/"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": name,
          if (password != null && password.isNotEmpty) "password": password,
          "phone": phone,
          "address": address,
          "age": age,
        }),
      );

      if (response.statusCode == 200) {
        _name = name;
        _phone = phone;
        _address = address;
        _age = age;
        notifyListeners();
        return true;
      } else {
        debugPrint("❌ Lỗi cập nhật thông tin: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("⚠️ Lỗi updateUserInfo: $e");
      return false;
    }
  }

  /// **🚪 Đăng xuất người dùng**
  Future<void> logoutUser() async {
    await AuthService.clearToken(); // 🔥 Xóa token đăng nhập
    _name = "Người dùng";
    _email = "example@gmail.com";
    _phone = "chua cap nhat";
    _address = "Chưa có địa chỉ";
    _age = 18;
    _isLoggedIn = false; // ✅ Đánh dấu đăng xuất

    notifyListeners();
  }
}
