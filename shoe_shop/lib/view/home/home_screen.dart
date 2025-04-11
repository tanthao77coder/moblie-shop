import 'package:flutter/material.dart';
import 'package:shoe_shop/view/home/components/home_app_bar.dart';
import 'package:shoe_shop/view/home/components/home_drawer.dart';
import 'package:shoe_shop/view/home/components/home_banner.dart';
import 'package:shoe_shop/view/home/components/category_list.dart';
import 'package:shoe_shop/view/home/components/product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCategories = true;
  bool _showFlashSale = false;
  bool _showFeaturedProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HomeAppBar(),
      ),
      drawer: const HomeDrawer(),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HomeBanner(),
              ),
              const SizedBox(height: 15),

              /// **Thanh điều hướng ngang**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToggleButton("Danh mục", _showCategories, () {
                      setState(() => _showCategories = !_showCategories);
                    }, Colors.orange),
                    _buildToggleButton("Flash Sale ⚡", _showFlashSale, () {
                      setState(() => _showFlashSale = !_showFlashSale);
                    }, Colors.red),
                    _buildToggleButton("Nổi bật", _showFeaturedProducts, () {
                      setState(() => _showFeaturedProducts = !_showFeaturedProducts);
                    }, Colors.amber),
                  ],
                ),
              ),

              /// **Danh mục sản phẩm**
              if (_showCategories) _buildSection("Danh mục sản phẩm", const CategoryList()),

              /// **Flash Sale**
              if (_showFlashSale)
                _buildSection(
                    "Flash Sale 🔥",
                    Container(
                      height: 200,
                      color: Colors.red[100],
                      child: const Center(
                          child: Text(
                            "Flash Sale đang diễn ra!",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                    )),

              /// **Sản phẩm nổi bật**
              if (_showFeaturedProducts) _buildSection("Sản phẩm Hot", const ProductList()),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// **Nút bật/tắt trạng thái của từng mục**
  Widget _buildToggleButton(String title, bool isActive, VoidCallback onTap, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Hiển thị từng mục với tiêu đề**
  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        content,
      ],
    );
  }
}
