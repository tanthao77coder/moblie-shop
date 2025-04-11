import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/view/product/product_item.dart';
import 'package:shoe_shop/providers/product_provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final products = productProvider.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Kiểm tra nếu danh sách rỗng
        if (products.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Không có sản phẩm nào", style: TextStyle(fontSize: 16)),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true, // ✅ Để tránh lỗi trong Column
              physics: const NeverScrollableScrollPhysics(), // ❌ Tắt cuộn Grid (vì đã có cuộn ngoài)
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ✅ 2 cột
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7, // ⚖️ Điều chỉnh tỷ lệ phù hợp
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(product: products[index]);
              },
            ),
          ),
      ],
    );
  }
}
