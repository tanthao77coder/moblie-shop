import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF8C00); // Màu cam chủ đạo
  static const Color secondaryColor = Color(0xFF00C896); // Màu xanh mint
  static const Color backgroundColor = Color(0xFFFFFFFF); // Nền trắng
  static const Color textColor = Color(0xFF222222); // Màu chữ đen

  static ThemeData lightTheme = ThemeData(
    fontFamily: null, // ✅ Dùng font hệ thống, không cần tải gì cả
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}
