import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_travel_planner/src/features/itinerary_management/presentation/bloc/itinerary_bloc.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/injection/widget/dependencies_scope.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItineraryBloc(
        DependenciesScope.of(context).tripRepository,
      )..add(const ItineraryEvent.started()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Trips'),
          elevation: 0,
        ),
        body: BlocBuilder<ItineraryBloc, ItineraryState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (trips) => _buildTripList(context, trips),
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTripList(BuildContext context, List<Trip> trips) {
    if (trips.isEmpty) {
      return const Center(child: Text('No trips yet'));
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      onReorder: (oldIndex, newIndex) {
        context.read<ItineraryBloc>().add(
              ItineraryEvent.reorderTrips(
                oldIndex,
                newIndex > oldIndex ? newIndex - 1 : newIndex,
              ),
            );
      },
      itemBuilder: (context, index) {
        final trip = trips[index];
        return Card(
          key: ValueKey(trip.id),
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              trip.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${trip.places.length} destinations',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.drag_handle),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDelete(context, trip),
                ),
              ],
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trip.places.length,
                itemBuilder: (context, placeIndex) {
                  final place = trip.places[placeIndex];
                  return ListTile(
                    leading: Text('${placeIndex + 1}'),
                    title: Text(place.name),
                    subtitle: Text(place.category.displayName),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, Trip trip) async {
    final delete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Trip'),
        content: Text('Are you sure you want to delete "${trip.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (delete == true) {
      if (!context.mounted) return;
      context.read<ItineraryBloc>().add(ItineraryEvent.deleteTrip(trip.id));
    }
  }
}
