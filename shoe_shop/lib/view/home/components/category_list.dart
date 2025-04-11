import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {"name": "Tất cả", "icon": Icons.dashboard},
    {"name": "Thể thao", "icon": Icons.directions_run},
    {"name": "Sneaker", "icon": Icons.sports_esports},
    {"name": "Cao gót", "icon": Icons.stairs},
    {"name": "Sandal", "icon": Icons.wb_sunny},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70, // 🔥 Giảm chiều cao giúp dễ vuốt hơn
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final bool isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // TODO: Gọi Provider để lọc danh mục
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6), // Giảm khoảng cách
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Kéo dài hình chữ nhật
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(12), // 🔥 Chuyển sang hình chữ nhật bo góc
                border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade300, width: 1),
                boxShadow: [
                  if (isSelected) // 🔥 Hiệu ứng nổi khi chọn
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Row(
                children: [
                  Icon(category["icon"], color: isSelected ? Colors.white : Colors.black),
                  const SizedBox(width: 8),
                  Text(
                    category["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
