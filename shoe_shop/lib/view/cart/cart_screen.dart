import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/cart_provider.dart';

final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        backgroundColor: Colors.orange,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return cartProvider.selectedItems.isNotEmpty
                  ? TextButton(
                onPressed: cartProvider.removeSelectedItems,
                child: const Text("Xóa", style: TextStyle(color: Colors.white)),
              )
                  : const SizedBox();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return const Center(
              child: Text("Giỏ hàng trống", style: TextStyle(fontSize: 18)),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// **📌 Checkbox chọn sản phẩm**
                          Checkbox(
                            value: cartProvider.selectedItems.contains(cartItem),
                            onChanged: (value) => cartProvider.toggleSelection(cartItem),
                          ),

                          /// **📌 Ảnh sản phẩm**
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              cartItem.product.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),

                          /// **📌 Thông tin sản phẩm**
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// **📌 Tên sản phẩm**
                                Text(
                                  cartItem.product.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),

                                /// **📌 Giá sản phẩm**
                                Row(
                                  children: [
                                    Text(
                                      currencyFormat.format(cartItem.product.price),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      currencyFormat.format(cartItem.product.originalPrice),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                /// **📌 Tùy chọn số lượng**
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: cartItem.quantity > 1
                                          ? () => cartProvider.updateQuantity(cartItem, cartItem.quantity - 1)
                                          : null,
                                    ),
                                    Text("${cartItem.quantity}", style: const TextStyle(fontSize: 16)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () => cartProvider.updateQuantity(cartItem, cartItem.quantity + 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// **💰 Thanh toán tổng tiền + Chọn tất cả**
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// **📌 Checkbox chọn tất cả**
                    Row(
                      children: [
                        Checkbox(
                          value: cartProvider.areAllSelected,
                          onChanged: (value) => cartProvider.toggleSelectAll(value!),
                        ),
                      ],
                    ),

                    /// **📌 Hiển thị tổng tiền rõ ràng**
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tổng tiền:", style: TextStyle(fontSize: 16)),
                        Text(
                          currencyFormat.format(cartProvider.selectedTotalPrice),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),

                    /// **📌 Nút thanh toán**
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cartProvider.selectedTotalPrice > 0 ? Colors.orange : Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: cartProvider.selectedTotalPrice > 0
                          ? () {
                        // TODO: Chuyển đến trang thanh toán
                      }
                          : null,
                      child: const Text("Thanh toán", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
