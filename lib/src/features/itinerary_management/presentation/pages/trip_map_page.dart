import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/bloc/trip_planner_bloc.dart';
import 'package:smart_travel_planner/src/injection/widget/dependencies_scope.dart';

class TripMapPage extends StatefulWidget {
  final Trip trip;

  const TripMapPage({required this.trip, super.key});

  @override
  State<TripMapPage> createState() => _TripMapPageState();
}

class _TripMapPageState extends State<TripMapPage> {
  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/map.json')
        .then((style) => _mapStyle = style);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripPlannerBloc(
        DependenciesScope.of(context).placesRepository,
        DependenciesScope.of(context).tripRepository,
      )..add(const TripPlannerEvent.started()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.trip.name),
          elevation: 0,
        ),
        body: BlocBuilder<TripPlannerBloc, TripPlannerState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (controller, markers, nearbyPlaces, destinations, position,
                  lastFetch, categories, routes, isLoading) {
                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        controller.setMapStyle(_mapStyle);
                        _initializeTrip(context);
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          widget.trip.places.first.latitude,
                          widget.trip.places.first.longitude,
                        ),
                        zoom: 12,
                      ),
                      markers: markers,
                      polylines: routes,
                      myLocationEnabled: true,
                    ),
                  ],
                );
              },
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }

  void _initializeTrip(BuildContext context) {
    for (var place in widget.trip.places) {
      context.read<TripPlannerBloc>().add(
            TripPlannerEvent.addDestination(place),
          );
    }
  }
}