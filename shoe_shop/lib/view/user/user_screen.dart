import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tài khoản",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF8C00), Color(0xFF00C896)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Ảnh đại diện + Thông tin người dùng
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/user.png"),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/profile"); // Chuyển tới ProfileScreen
                    },
                    child: Column(
                      children: [
                        Text(
                          userProvider.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          userProvider.email,
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Danh sách menu (Làm nổi bật hơn)
            _buildMenuItem(Icons.notifications, "Thông báo", () {}),
            _buildMenuItem(Icons.history, "Lịch sử đơn hàng", () {}),
            _buildMenuItem(Icons.contact_mail, "Liên hệ", () {}),
            _buildMenuItem(Icons.settings, "Cài đặt", () {}),
            _buildMenuItem(Icons.logout, "Đăng xuất", () {
              // Xử lý đăng xuất
            }),
          ],
        ),
      ),
    );
  }

  //  giao diện mục menu
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: Colors.orange, size: 28),
          title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}
