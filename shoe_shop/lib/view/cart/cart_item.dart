import 'package:shoe_shop/providers/product_provider.dart';
import 'package:shoe_shop/view/product/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  /// ✅ Tính tổng giá của sản phẩm trong giỏ hàng
  double get totalPrice => product.price * quantity;

  /// ✅ Kiểm tra hai `CartItem` có phải cùng một sản phẩm không (Dùng để tránh trùng lặp)
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is CartItem && other.product.id == product.id);
  }

  /// ✅ Định nghĩa `hashCode` dựa trên `product.id`
  @override
  int get hashCode => product.id.hashCode;
}
