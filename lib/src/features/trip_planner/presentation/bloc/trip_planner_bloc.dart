import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/places_repository.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/trip_repository.dart';

part 'trip_planner_event.dart';
part 'trip_planner_state.dart';
part 'trip_planner_bloc.freezed.dart';

class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
  final PlacesRepository _placesRepository;
  final TripRepository _tripRepository;
  static const _debounceTime = Duration(milliseconds: 300);
  static const _minDistanceToFetch = 300.0;
  static const _maxDestinations = 5;
  Function(Place)? onPlaceMarkerTap;
  bool _isProcessingDestination = false;

  TripPlannerBloc(this._placesRepository, this._tripRepository)
      : super(const TripPlannerState.initial()) {
    on<_Started>(_onStarted);
    on<_MapCreated>(_onMapCreated);
    on<_CameraMoved>(_onCameraMoved,
        transformer: _debounceAndThrottle(_debounceTime));
    on<_ToggleCategory>(_onToggleCategory);
    on<_AddDestination>(_onAddDestination);
    on<_RemoveDestination>(_onRemoveDestination);
    on<_SearchPlace>(_onSearchPlace);
    on<_ClearDestinations>(_onClearDestinations);
    on<_RecalculateRoute>(_onRecalculateRoute);
    on<_SaveTrip>(_onSaveTrip);
  }

  /// Debounce and throttle events to prevent multiple requests
  /// within a short period of time.
  EventTransformer<T> _debounceAndThrottle<T>(Duration duration) {
    return (events, mapper) => events
        .throttleTime(duration)
        .debounceTime(duration)
        .asyncExpand(mapper);
  }

  /// Returns true if more destinations can be added.
  /// The limit is set to 5 destinations.
  bool get canAddMoreDestinations {
    if (state is! _Loaded) return false;
    return (state as _Loaded).destinationsMap.length < _maxDestinations;
  }

  Future<void> _onStarted(
      _Started event, Emitter<TripPlannerState> emit) async {
    emit(const TripPlannerState.loading());

    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(const TripPlannerState.error('Location service is disabled'));
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(const TripPlannerState.error('Location permission denied'));
        return;
      }
    }

    try {
      final currentLocation = await location.getLocation();
      final position =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      final places = await _placesRepository.getNearbyPlaces(position, 3000);
      final placesMap = {for (var place in places) place.id: place};

      emit(TripPlannerState.loaded(
        mapController: null,
        markers: _createMarkers(places, const []),
        nearbyPlacesMap: placesMap,
        destinationsMap: const {},
        initialPosition: position,
        lastFetchPosition: position,
      ));
    } catch (e) {
      emit(const TripPlannerState.error('Failed to initialize map'));
    }
  }

  void _onMapCreated(_MapCreated event, Emitter<TripPlannerState> emit) {
    final currentState = state;
    if (currentState is! _Loaded) return;
    emit(currentState.copyWith(mapController: event.controller));
  }

  Future<void> _onCameraMoved(
      _CameraMoved event, Emitter<TripPlannerState> emit) async {
    if (state is! _Loaded || _isProcessingDestination) return;
    final currentState = state as _Loaded;

    if (!_shouldFetchNewPlaces(
        event.position, currentState.lastFetchPosition)) {
      return;
    }

    try {
      /// Calculate radius based on zoom level
      final radius = _calculateRadius(
          await currentState.mapController?.getZoomLevel() ?? 12.0);

      /// Fetch nearby places
      final places = await _placesRepository.getNearbyPlaces(
        event.position,
        radius,
        categories: currentState.selectedCategories,
      );

      /// Update nearby places map for caching
      final newPlacesMap =
          Map<String, Place>.from(currentState.nearbyPlacesMap);
      for (final place in places) {
        newPlacesMap[place.id] = place;
      }

      /// Remove places that are too far away because of prevent memory leaks
      newPlacesMap.removeWhere((_, place) {
        if (currentState.destinationsMap.containsKey(place.id)) return false;
        return _calculateDistance(
                event.position, LatLng(place.latitude, place.longitude)) >
            5000;
      });

      /// Preserve search marker if exists
      Marker? searchMarker;
      for (final marker in currentState.markers) {
        if (marker.markerId.value == 'search_result') {
          searchMarker = marker;
          break;
        }
      }

      /// Update markers
      final updatedMarkers = _createMarkers(
        newPlacesMap.values.toList(),
        currentState.destinationsMap.values.toList(),
      );

      /// Add search marker back if exists
      if (searchMarker != null) {
        updatedMarkers.add(searchMarker);
      }

      /// Update state
      emit(currentState.copyWith(
        markers: updatedMarkers,
        nearbyPlacesMap: newPlacesMap,
        lastFetchPosition: event.position,
        destinationsMap: currentState.destinationsMap,
        routes: currentState.routes,
        isLoading: false,
      ));
    } catch (e) {
      if (!isClosed) {
        emit(currentState.copyWith(
          isLoading: false,
        ));
      }
    }
  }

  Future<void> _onSaveTrip(
      _SaveTrip event, Emitter<TripPlannerState> emit) async {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;

    try {
      final trip = Trip(
        id: 0,
        name: event.name,
        places: event.places,
        startDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Create trip first to get ID
      final tripId = await _tripRepository.createTrip(trip);

      // Update trip with places
      final tripWithId = trip.copyWith(id: tripId);
      await _tripRepository.updateTrip(tripWithId);

      // Clear destinations after saving
      emit(currentState.copyWith(
        destinationsMap: const {},
        routes: const {},
        markers: _createMarkers(
          currentState.nearbyPlacesMap.values.toList(),
          const [],
        ),
      ));
    } catch (e) {
      log('Failed to save trip: $e');
    }
  }

  Future<void> _onRecalculateRoute(
      _RecalculateRoute event, Emitter<TripPlannerState> emit) async {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;

    try {
      emit(currentState.copyWith(isLoading: true));

      final routes =
          await _createRoutes(currentState.destinationsMap.values.toList());

      if (!emit.isDone) {
        emit(currentState.copyWith(
          routes: routes,
          isLoading: false,
        ));
      }
    } catch (e) {
      log('Failed to recalculate route: $e');
      if (!emit.isDone) {
        emit(currentState.copyWith(isLoading: false));
      }
    }
  }

  double _calculateRadius(double zoom) {
    if (zoom <= 8) return 10000;
    if (zoom <= 10) return 5000;
    if (zoom <= 12) return 2500;
    if (zoom <= 14) return 1000;
    if (zoom <= 16) return 500;
    return 250;
  }

  Future<void> _onToggleCategory(
      _ToggleCategory event, Emitter<TripPlannerState> emit) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final updatedCategories =
        Set<PlaceCategory>.from(currentState.selectedCategories);
    if (updatedCategories.contains(event.category)) {
      updatedCategories.remove(event.category);
    } else {
      updatedCategories.add(event.category);
    }

    final filteredPlaces = currentState.nearbyPlacesMap.values.where((place) {
      if (updatedCategories.isEmpty) return true;
      return updatedCategories.contains(place.category);
    }).toList();

    emit(currentState.copyWith(
      selectedCategories: updatedCategories,
      markers: _createMarkers(
          filteredPlaces, currentState.destinationsMap.values.toList()),
      routes: currentState.routes, // Preserve routes
    ));
  }

  Future<void> _onAddDestination(
      _AddDestination event, Emitter<TripPlannerState> emit) async {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;

    // Check destination limit
    if (currentState.destinationsMap.length >= _maxDestinations) {
      return;
    }

    _isProcessingDestination = true;
    try {
      final updatedState =
          await _updateDestinationsAndMarkers(currentState, event.place);
      if (!emit.isDone) emit(updatedState);

      final finalState = await _calculateRoutes(updatedState as _Loaded);
      if (!emit.isDone) emit(finalState);
    } finally {
      _isProcessingDestination = false;
    }
  }

  Future<TripPlannerState> _updateDestinationsAndMarkers(
    _Loaded currentState,
    Place newPlace,
  ) async {
    final updatedDestinations =
        Map<String, Place>.from(currentState.destinationsMap)
          ..putIfAbsent(newPlace.id, () => newPlace);

    return currentState.copyWith(
      destinationsMap: updatedDestinations,
      markers: _createMarkers(
        currentState.nearbyPlacesMap.values.toList(),
        updatedDestinations.values.toList(),
      ),
      isLoading: true,
    );
  }

  Future<TripPlannerState> _calculateRoutes(_Loaded currentState) async {
    final routes =
        await _createRoutes(currentState.destinationsMap.values.toList());

    return currentState.copyWith(
      routes: routes,
      isLoading: false,
    );
  }

  Future<void> _onSearchPlace(
      _SearchPlace event, Emitter<TripPlannerState> emit) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(currentState.copyWith(isLoading: true));

    try {
      final searchResults = await _placesRepository.searchPlaces(event.query);
      if (searchResults.isNotEmpty) {
        final searchedPlace = searchResults.first;
        final position =
            LatLng(searchedPlace.latitude, searchedPlace.longitude);

        final searchMarker = Marker(
          markerId: const MarkerId('search_result'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              _getCategoryHue(searchedPlace.category)),
          infoWindow: InfoWindow(
            title: searchedPlace.name,
            snippet:
                searchedPlace.address ?? searchedPlace.category.displayName,
          ),
          onTap: () => onPlaceMarkerTap?.call(searchedPlace),
        );

        // Preserve existing markers except old search marker
        final updatedMarkers = currentState.markers
            .where((m) => m.markerId.value != 'search_result')
            .toSet()
          ..add(searchMarker);

        emit(currentState.copyWith(
          markers: updatedMarkers,
          isLoading: false,
        ));

        if (currentState.mapController != null) {
          await currentState.mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(position, 15),
          );
        }
      }
    } catch (e) {
      log('Error searching places: $e');
      emit(currentState.copyWith(isLoading: false));
    }
  }

  Future<Set<Polyline>> _createRoutes(List<Place> destinations) async {
    if (destinations.length < 2) return {};

    try {
      // Get last two points for the new route segment
      final origin = destinations[destinations.length - 2];
      final destination = destinations.last;

      final routePoints = await _placesRepository.getRouteBetweenPoints(
        LatLng(origin.latitude, origin.longitude),
        LatLng(destination.latitude, destination.longitude),
      );

      // Create new route segment
      final newRoute = Polyline(
        polylineId: PolylineId('route_${origin.id}_${destination.id}'),
        points: routePoints,
        color: Colors.blue,
        width: 5,
        geodesic: true,
      );

      // Add to existing routes if state has previous routes
      if (state is _Loaded) {
        final currentState = state as _Loaded;
        return {...currentState.routes, newRoute};
      }

      return {newRoute};
    } catch (e) {
      log('Failed to create route: $e');
      return {};
    }
  }

  bool _shouldFetchNewPlaces(LatLng newPosition, LatLng? lastPosition) {
    if (lastPosition == null) return true;
    return _calculateDistance(lastPosition, newPosition) >= _minDistanceToFetch;
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const earthRadius = 6371000.0;
    final lat1 = from.latitude * math.pi / 180;
    final lat2 = to.latitude * math.pi / 180;
    final dLat = (to.latitude - from.latitude) * math.pi / 180;
    final dLon = (to.longitude - from.longitude) * math.pi / 180;

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  Set<Marker> _createMarkers(List<Place> places, List<Place> destinations) {
    final destinationIds = destinations.map((d) => d.id).toSet();

    return {
      ...places
          .where((place) => !destinationIds.contains(place.id))
          .map((place) => _createPlaceMarker(place)),
      ...destinations
          .asMap()
          .entries
          .map((entry) => _createDestinationMarker(entry.value, entry.key)),
    };
  }

  double _getCategoryHue(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurant:
        return BitmapDescriptor.hueRed;
      case PlaceCategory.hotel:
        return BitmapDescriptor.hueBlue;
      case PlaceCategory.attraction:
        return BitmapDescriptor.hueViolet;
      default:
        return BitmapDescriptor.hueGreen;
    }
  }

  void _onClearDestinations(
      _ClearDestinations event, Emitter<TripPlannerState> emit) {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(currentState.copyWith(
      destinationsMap: const {},
      routes: const {},
      markers: _createMarkers(
        currentState.nearbyPlacesMap.values.toList(),
        const [], // Empty destinations list
      ),
    ));
  }

  Future<void> _onRemoveDestination(
      _RemoveDestination event, Emitter<TripPlannerState> emit) async {
    if (state is! _Loaded) return;
    final currentState = state as _Loaded;

    try {
      // Remove destination
      final oldDestinations = currentState.destinationsMap.values.toList();
      final placeId = oldDestinations[event.index].id;
      final updatedDestinations =
          Map<String, Place>.from(currentState.destinationsMap)
            ..remove(placeId);

      final destinations = updatedDestinations.values.toList();
      final updatedRoutes = <Polyline>{};

      // Rebuild routes for remaining destinations
      if (destinations.length >= 2) {
        for (var i = 0; i < destinations.length - 1; i++) {
          final origin = destinations[i];
          final destination = destinations[i + 1];

          final routePoints = await _placesRepository.getRouteBetweenPoints(
            LatLng(origin.latitude, origin.longitude),
            LatLng(destination.latitude, destination.longitude),
          );

          updatedRoutes.add(
            Polyline(
              polylineId: PolylineId('route_${origin.id}_${destination.id}'),
              points: routePoints,
              color: Colors.blue,
              width: 5,
              geodesic: true,
            ),
          );
        }
      }

      emit(currentState.copyWith(
        destinationsMap: updatedDestinations,
        routes: updatedRoutes,
        markers: _createMarkers(
          currentState.nearbyPlacesMap.values.toList(),
          destinations,
        ),
      ));
    } catch (e) {
      log('Failed to remove destination: $e');
    }
  }

  Marker _createPlaceMarker(Place place) {
    return Marker(
      markerId: MarkerId('place_${place.id}'),
      position: LatLng(place.latitude, place.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          _getCategoryHue(place.category)),
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.address ?? place.category.displayName,
      ),
      onTap: () => onPlaceMarkerTap?.call(place),
    );
  }

  Marker _createDestinationMarker(Place place, int index) {
    return Marker(
      markerId: MarkerId('destination_$index'),
      position: LatLng(place.latitude, place.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: place.name,
        snippet: 'Stop ${index + 1}',
      ),
    );
  }
}
