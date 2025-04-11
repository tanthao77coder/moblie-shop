import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/providers/product_provider.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Loại giày
          _buildDropdown(
            "Loại giày",
            productProvider.selectedCategory,
            productProvider.categories,
                (newValue) => productProvider.setCategory(newValue),
          ),

          // Thương hiệu
          _buildDropdown(
            "Thương hiệu",
            productProvider.selectedBrand,
            productProvider.brands,
                (newValue) => productProvider.setBrand(newValue),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String) onChanged) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (newValue) => onChanged(newValue!),
          ),
        ],
      ),
    );
  }
}
