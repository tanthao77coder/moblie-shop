import 'package:flutter/material.dart';
import 'package:shoe_shop/view/cart/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final Set<CartItem> _selectedItems = {};

  List<CartItem> get cartItems => _cartItems;
  Set<CartItem> get selectedItems => _selectedItems;

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  double get selectedTotalPrice => _selectedItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  bool get areAllSelected => _selectedItems.length == _cartItems.length;

  /// **🛒 Thêm sản phẩm vào giỏ hàng (Cộng dồn số lượng nếu trùng)**
  void addToCart(CartItem item) {
    int index = _cartItems.indexWhere((cartItem) => cartItem.product.id == item.product.id);

    if (index != -1) {
      // Nếu sản phẩm đã có trong giỏ hàng, chỉ tăng số lượng
      _cartItems[index].quantity += item.quantity;
    } else {
      // Nếu chưa có, thêm mới vào giỏ hàng
      _cartItems.add(item);
    }
    notifyListeners();
  }

  /// **🔄 Cập nhật số lượng sản phẩm**
  void updateQuantity(CartItem item, int quantity) {
    if (quantity < 1) {
      _cartItems.remove(item); // Nếu số lượng = 0 thì xóa khỏi giỏ hàng
    } else {
      item.quantity = quantity;
    }
    notifyListeners();
  }

  /// **🔘 Chọn / Bỏ chọn sản phẩm**
  void toggleSelection(CartItem item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
    notifyListeners();
  }

  /// **📌 Chọn tất cả / Bỏ chọn tất cả**
  void toggleSelectAll(bool selectAll) {
    if (selectAll) {
      _selectedItems.addAll(_cartItems);
    } else {
      _selectedItems.clear();
    }
    notifyListeners();
  }

  /// **🗑 Xóa các sản phẩm đã chọn**
  void removeSelectedItems() {
    _cartItems.removeWhere((item) => _selectedItems.contains(item));
    _selectedItems.clear();
    notifyListeners();
  }

  /// **🧹 Xóa toàn bộ giỏ hàng**
  void clearCart() {
    _cartItems.clear();
    _selectedItems.clear();
    notifyListeners();
  }
}

