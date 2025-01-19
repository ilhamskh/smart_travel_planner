import 'package:flutter/material.dart';
import '../../domain/entity/place_category.dart';

class CategoryFilter extends StatelessWidget {
  final Set<PlaceCategory> selectedCategories;
  final Function(PlaceCategory) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: PlaceCategory.values.map((category) {
          final isSelected = selectedCategories.contains(category);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Row(
                children: [
                  Icon(
                    _getPlaceIcon(category),
                    size: 18,
                    color: isSelected ? Colors.white : _getPlaceColor(category),
                  ),
                  const SizedBox(width: 4),
                  Text(category.displayName),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onCategorySelected(category),
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              selectedColor: _getPlaceColor(category),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getPlaceIcon(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurant:
        return Icons.restaurant;
      case PlaceCategory.hotel:
        return Icons.hotel;
      case PlaceCategory.attraction:
        return Icons.attractions;
    }
  }

  Color _getPlaceColor(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurant:
        return Colors.red;
      case PlaceCategory.hotel:
        return Colors.blue;
      case PlaceCategory.attraction:
        return Colors.purple;
    }
  }
}