import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/view/product/product_item.dart';
import 'package:shoe_shop/providers/product_provider.dart';
import 'package:shoe_shop/view/product/filter_dropdown.dart';

final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sản phẩm",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **📌 Bộ lọc sản phẩm**
          const FilterDropdown(),

          // **📌 Hiển thị số lượng sản phẩm tìm thấy**
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              "Tìm thấy ${products.length} sản phẩm",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // **📌 Danh sách sản phẩm**
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12, // ✅ Tăng khoảng cách ngang
                mainAxisSpacing: 14, // ✅ Tăng khoảng cách dọc
                childAspectRatio: 0.75, // ✅ Căn chỉnh tỷ lệ để không bị méo hình
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Hero(
                  tag: "product_${product.id}",
                  child: ProductItem(product: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
