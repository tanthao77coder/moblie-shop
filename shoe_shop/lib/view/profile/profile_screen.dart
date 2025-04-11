import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _ageController;
  bool _obscurePassword = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserInfo(); // 🔥 Gọi API lấy thông tin người dùng

    setState(() {
      _nameController = TextEditingController(text: userProvider.name);
      _emailController = TextEditingController(text: userProvider.email);
      _passwordController = TextEditingController(text: ""); // Không hiển thị mật khẩu cũ
      _phoneController = TextEditingController(text: userProvider.phone);
      _addressController = TextEditingController(text: userProvider.address);
      _ageController = TextEditingController(text: userProvider.age.toString());
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Hiển thị loading khi chưa có dữ liệu
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF8C00), Color(0xFF00C896)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// **📌 Avatar hình đôi giày**
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/shoe_icon.png"), // 🔥 Avatar giày
                    ),
                    const SizedBox(height: 20),

                    /// **📌 Các trường nhập dữ liệu**
                    _buildTextField("Họ và tên", _nameController, Icons.person),
                    _buildTextField("Email", _emailController, Icons.email, enabled: false),
                    _buildTextField("Mật khẩu mới", _passwordController, Icons.lock, isPassword: true),
                    _buildTextField("Số điện thoại", _phoneController, Icons.phone),
                    _buildTextField("Tuổi", _ageController, Icons.cake),
                    _buildTextField("Địa chỉ", _addressController, Icons.home),

                    const SizedBox(height: 20),

                    /// **📌 Nút lưu thông tin**
                    ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Lưu thông tin", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **📌 Widget tạo ô nhập liệu**
  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isPassword = false, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.orange),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.orange),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  /// **📌 Lưu thông tin người dùng**
  void _saveProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool success = await userProvider.updateUserInfo(
      name: _nameController.text,
      password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
      phone: _phoneController.text,
      address: _addressController.text,
      age: int.tryParse(_ageController.text) ?? userProvider.age,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thông tin đã được cập nhật!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thất bại, vui lòng thử lại!")),
      );
    }
  }
}
