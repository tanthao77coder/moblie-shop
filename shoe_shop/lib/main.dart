import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/cart_provider.dart';
import 'package:shoe_shop/providers/product_provider.dart';
import 'package:shoe_shop/providers/user_provider.dart';
import 'package:shoe_shop/theme/app_theme.dart';
import 'package:shoe_shop/view/cart/cart_screen.dart';
import 'package:shoe_shop/view/home/home_screen.dart';
import 'package:shoe_shop/view/product/product_screen.dart';
import 'package:shoe_shop/widget/bottom_nav_bar.dart';
import 'package:shoe_shop/view/auth/login_screen.dart';
import 'package:shoe_shop/view/auth/register_screen.dart';
import 'package:shoe_shop/view/profile/profile_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOAT SHOP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const BottomNavBar(), //  BottomNavBar làm nền chính
      routes: {
        "/home": (context) => const BottomNavBar(),
        "/login": (context) => const LoginScreen(),     // ✅ Thêm trang đăng nhập
        "/register": (context) => const RegisterScreen(), // ✅ Thêm trang đăng ký
        "/profile": (context) => const ProfileScreen(),
        "/products": (context) => const ProductScreen(),
        "/cart": (context) => const CartScreen(),
      },
    );
  }
}

