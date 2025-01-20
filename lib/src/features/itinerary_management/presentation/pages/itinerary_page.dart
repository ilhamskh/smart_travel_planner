import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_travel_planner/src/core/widget/error_snackbar.dart';
import 'package:smart_travel_planner/src/core/widget/error_view.dart';
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
        body: BlocListener<ItineraryBloc, ItineraryState>(
          listenWhen: (previous, current) => current.maybeMap(
            error: (_) => true,
            orElse: () => false,
          ),
          listener: (context, state) {
            state.maybeMap(
              error: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackBar(message: error.message),
                );
              },
              orElse: () {},
            );
          },
          child: BlocBuilder<ItineraryBloc, ItineraryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (trips) => _buildTripList(context, trips),
                error: (message) => ErrorView(
                  message: message,
                  onRetry: () => context
                      .read<ItineraryBloc>()
                      .add(const ItineraryEvent.started()),
                ),
              );
            },
          ),
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
            title: Text(trip.name),
            subtitle: Text('${trip.places.length} destinations'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.drag_handle),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditTripDialog(context, trip),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDelete(context, trip),
                ),
                //Route to TripMapPage
                IconButton(
                  icon: const Icon(Icons.map),
                  onPressed: () => context.push('/trip-map', extra: trip),
                ),
              ],
            ),
            children: [
              if (trip.places.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
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
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showEditTripDialog(BuildContext context, Trip trip) async {
    final nameController = TextEditingController(text: trip.name);

    final shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Trip'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Trip Name',
            hintText: 'Enter a new name for your trip',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (shouldUpdate == true && nameController.text.isNotEmpty) {
      if (!context.mounted) return;
      context.read<ItineraryBloc>().add(
            ItineraryEvent.updateTrip(
              trip.copyWith(
                name: nameController.text,
                updatedAt: DateTime.now(),
              ),
            ),
          );
    }
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
