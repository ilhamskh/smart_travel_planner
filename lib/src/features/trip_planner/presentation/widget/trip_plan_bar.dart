import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';

class TripPlanBar extends StatelessWidget {
  final List<Place> destinations;
  final Function(int) onRemoveDestination;
  
  const TripPlanBar({
    required this.destinations,
    required this.onRemoveDestination,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: destinations.isEmpty ? 0 : 120,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.route, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Your Trip Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: Colors.grey),
                ),
                itemBuilder: (context, index) => Chip(
                  label: Text(destinations[index].name),
                  onDeleted: () => onRemoveDestination(index),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 