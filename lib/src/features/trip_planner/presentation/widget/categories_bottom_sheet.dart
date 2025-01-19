import 'package:flutter/material.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';

class CategoriesBottomSheet extends StatelessWidget {
  final Set<PlaceCategory> selectedCategories;
  final Function(PlaceCategory) onCategorySelected;

  const CategoriesBottomSheet({
    required this.selectedCategories,
    required this.onCategorySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.category),
              const SizedBox(width: 8),
              Text(
                'Filter Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: PlaceCategory.values.map((category) {
              final isSelected = selectedCategories.contains(category);
              return FilterChip(
                selected: isSelected,
                label: Text(category.displayName),
                onSelected: (_) => onCategorySelected(category),
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.blue.withOpacity(0.2),
                checkmarkColor: Colors.blue,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
} 