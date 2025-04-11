import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/user_provider.dart';
import 'package:shoe_shop/services/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final bool isLoggedIn = userProvider.isLoggedIn;
    final String userName = userProvider.name;

    return Drawer(
      child: Column(
        children: [
          // **📌 Header của Drawer**
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            width: double.infinity,
            color: Colors.orange,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/user.png"), // 🖼 Ảnh demo
                ),
                const SizedBox(height: 10),
                isLoggedIn
                    ? Text(
                  "Xin chào, $userName", // 🛠 Hiển thị đúng tên từ API
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: const Text("Đăng nhập", style: TextStyle(color: Colors.white)),
                    ),
                    const Text(" | ", style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text("Đăng ký", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // **📌 Danh sách menu**
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(Icons.home, "Trang chủ", () {
                  Navigator.pushReplacementNamed(context, "/home");
                }),
                _buildDrawerItem(Icons.category, "Sản phẩm", () {}),
                _buildDrawerItem(Icons.contact_mail, "Liên hệ", () {}),
                _buildDrawerItem(Icons.local_offer, "Khuyến mãi", () {}),
                _buildDrawerItem(Icons.info, "Giới thiệu", () {}),

                // **📌 Nếu đã đăng nhập -> Hiển thị nút Đăng xuất**
                if (isLoggedIn)
                  _buildDrawerItem(Icons.logout, "Đăng xuất", () async {
                    await AuthService.logout();
                    userProvider.logoutUser(); // 🔥 Cập nhật trạng thái
                    Navigator.pushReplacementNamed(context, "/login");
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
