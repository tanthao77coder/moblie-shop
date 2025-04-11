import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFFD84315)], // 🌅 Gradient Cam -> Đỏ
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),

      /// **📌 Nút Menu LỚN hơn**
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, size: 30, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),

      /// **🔥 Tên thương hiệu Gradient Đen - Đỏ**
      title: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: "GOAT ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black, // ⚫ Màu đen
              ),
            ),
            TextSpan(
              text: "SHOP",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.black, Colors.red], // 🔴 Gradient Đen -> Đỏ
                  ).createShader(const Rect.fromLTWH(0, 0, 100, 20)),
              ),
            ),
          ],
        ),
      ),

      /// **🔍 Ô tìm kiếm gọn gàng**
      actions: [
        Container(
          width: 140,
          height: 36,
          margin: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.search, color: Colors.orange),
            ],
          ),
        ),

        /// **🛒 Nút giỏ hàng + Badge số lượng**
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/cart"); // ✅ Điều hướng tới giỏ hàng
              },
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: const Text(
                  '4',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
