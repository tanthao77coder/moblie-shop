class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String category;
  final String brand;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.brand,
  });

  /// **📌 Tính % giảm giá (Dựa trên giá gốc và giá giảm)**
  double get discountPercentage {
    if (originalPrice <= 0) return 0; // Tránh chia cho 0
    return ((originalPrice - price) / originalPrice) * 100;
  }
}
