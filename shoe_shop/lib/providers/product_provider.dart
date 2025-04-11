import 'package:flutter/material.dart';
import 'package:shoe_shop/view/product/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: "1",
      name: "Nike Air",
      imageUrl: "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/e783e052-9360-4afb-adb8-c4e9c0f5db07/NIKE+AIR+MAX+NUAXIS.png",
      price: 2000000.0,
      originalPrice: 2500000.0, // 💰 Giá gốc
      category: "Giày thể thao",
      brand: "Nike",
    ),
    Product(
      id: "2",
      name: "Adidas Boost",
      imageUrl: "https://assets.adidas.com/images/w_600,f_auto,q_auto/ba300702bce9426d95cc17953faa35df_9366/Giay_Ultraboost_5x_DJen_IH3110_HM1.jpg",
      price: 1800000.0,
      originalPrice: 2200000.0,
      category: "Giày thể thao",
      brand: "Adidas",
    ),
    Product(
      id: "3",
      name: "Puma Classic",
      imageUrl: "https://supersports.com.vn/cdn/shop/files/39520502-2_1024x1024.jpg?v=1714986894",
      price: 1500000.0,
      originalPrice: 1800000.0,
      category: "Giày sneaker",
      brand: "Puma",
    ),
    Product(
      id: "4",
      name: "Converse",
      imageUrl: "https://product.hstatic.net/200000265619/product/568497c-thumb-web_19a679fd48aa48a4a50eae354087309c_1024x1024.jpg",
      price: 1200000.0,
      originalPrice: 1500000.0,
      category: "Giày sneaker",
      brand: "Converse",
    ),
    Product(
      id: "5",
      name: "Nike Air Max",
      imageUrl: "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/a7f07bf7-7896-48c7-b53d-ab5daf86f84e/NIKE+AIR+MAX+EXCEE.png",
      price: 2000000,
      originalPrice: 2600000.0,
      category: "Giày thể thao",
      brand: "Nike",
    ),
    Product(
      id: "6",
      name: "Adidas UltraBoost Light",
      imageUrl: "https://assets.adidas.com/images/w_600,f_auto,q_auto/dfeaac2e2d8f46558e76af7f010bafe5_9366/Giay_Ultraboost_Light_DJen_HQ6339_01_standard.jpg",
      price: 1800000,
      originalPrice: 2300000.0,
      category: "Giày thể thao",
      brand: "Adidas",
    ),
  ];

  List<Product> get products => _products;

  // 🏷 **Bộ lọc sản phẩm**
  String _selectedCategory = "Tất cả";
  String _selectedBrand = "Tất cả";
  String _selectedPriceRange = "Tất cả";

  List<String> get categories => ["Tất cả", ..._products.map((p) => p.category).toSet()];
  List<String> get brands => ["Tất cả", ..._products.map((p) => p.brand).toSet()];
  List<String> get priceRanges => ["Tất cả", "Dưới 1 triệu", "1 - 2 triệu", "Trên 2 triệu"];

  String get selectedCategory => _selectedCategory;
  String get selectedBrand => _selectedBrand;
  String get selectedPriceRange => _selectedPriceRange;

  /// **📌 Lọc danh sách sản phẩm theo bộ lọc**
  List<Product> get filteredProducts {
    return _products.where((product) {
      bool matchCategory = _selectedCategory == "Tất cả" || product.category == _selectedCategory;
      bool matchBrand = _selectedBrand == "Tất cả" || product.brand == _selectedBrand;
      bool matchPrice = _selectedPriceRange == "Tất cả" || _isPriceInRange(product.price);

      return matchCategory && matchBrand && matchPrice;
    }).toList();
  }

  /// **⚡ Cập nhật bộ lọc**
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setBrand(String brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  void setPriceRange(String range) {
    _selectedPriceRange = range;
    notifyListeners();
  }

  /// **📊 Kiểm tra giá có nằm trong khoảng giá không?**
  bool _isPriceInRange(double price) {
    switch (_selectedPriceRange) {
      case "Dưới 1 triệu":
        return price < 1000000;
      case "1 - 2 triệu":
        return price >= 1000000 && price <= 2000000;
      case "Trên 2 triệu":
        return price > 2000000;
      default:
        return true;
    }
  }
}
