import 'package:flutter/material.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';

class PlaceDetailsBottomSheet extends StatelessWidget {
  final Place place;
  final VoidCallback onAddDestination;
  final bool canAddDestination;

  const PlaceDetailsBottomSheet({
    required this.place,
    required this.onAddDestination,
    required this.canAddDestination,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            place.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (place.address != null) ...[
            Text(
              place.address!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
          Text(
            'Category: ${place.category.displayName}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
              ),
              onPressed: canAddDestination ? onAddDestination : null,
              child: Text(
                canAddDestination
                    ? 'Add to Destinations'
                    : 'Maximum destinations reached (5)',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
