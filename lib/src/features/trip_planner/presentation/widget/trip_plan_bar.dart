import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/bloc/trip_planner_bloc.dart';

class TripPlanBar extends StatelessWidget {
  final List<Place> destinations;
  final Function(int) onRemoveDestination;
  final Function() onAddTrip;

  const TripPlanBar({
    required this.destinations,
    required this.onRemoveDestination,
    required this.onAddTrip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: destinations.isEmpty ? 0 : 180,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
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
                const Spacer(),
                Text(
                  '${destinations.length} destinations',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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
            if (destinations.isNotEmpty) ...[
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(
                    double.infinity,
                    0,
                  ),
                ),
                onPressed: () => _showSaveTripDialog(context),
                child: const Text(
                  'Save Trip',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _showSaveTripDialog(BuildContext context) async {
    final nameController = TextEditingController();

    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Trip'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Trip Name',
            hintText: 'Enter a name for your trip',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (shouldSave == true && nameController.text.isNotEmpty) {
      onAddTrip();
      context.read<TripPlannerBloc>().add(
            TripPlannerEvent.saveTrip(
              nameController.text,
              destinations,
            ),
          );
    }
  }
}
