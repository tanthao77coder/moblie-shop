// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shoe_shop/providers/product_provider.dart';
//
// class CategorySelector extends StatelessWidget {
//   const CategorySelector({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//
//     return SizedBox(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: productProvider.categories.length,
//         itemBuilder: (context, index) {
//           final category = productProvider.categories[index];
//           final isSelected = productProvider.selectedCategory == category;
//
//           return GestureDetector(
//             onTap: () {
//               productProvider.filterByCategory(category);
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.orange : Colors.grey[300],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Text(
//                   category,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
