import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:smart_travel_planner/src/database/dao/place_dao.dart';
import 'package:smart_travel_planner/src/database/dao/trip_dao.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripDao _dao;
  final PlaceDao _placeDao;

  TripRepositoryImpl(this._dao, this._placeDao);

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      final trips = await _dao.getAllTrips();
      log('Found ${trips.length} trips in database'); // Debug log

      final tripsWithPlaces = await Future.wait(
        trips.map((trip) async {
          final places = await _placeDao.getPlacesByTripId(trip.id);
          log('Found ${places.length} places for trip ${trip.id}'); // Debug log

          return trip.toEntity().copyWith(
                places: places.map((p) => p.toEntity()).toList(),
              );
        }),
      );
      return tripsWithPlaces;
    } catch (e) {
      log('Failed to get trips: $e');
      rethrow;
    }
  }

  @override
  Future<int> createTrip(Trip trip) async {
    try {
      return await _dao.transaction(() async {
        // 1. Create trip first
        final tripId = await _dao.createTrip(trip.toCompanion());
        log('Created trip with ID: $tripId'); // Debug log

        // 2. Create places with correct tripId
        for (final place in trip.places) {
          await _placeDao.createPlace(
            PlaceTableCompanion.insert(
              id: place.id,
              name: place.name,
              category: place.category.name,
              latitude: place.latitude,
              longitude: place.longitude,
              description: Value(place.description),
              imageUrl: Value(place.imageUrl),
              address: Value(place.address),
              tripId: Value(tripId),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        }
        log('Added ${trip.places.length} places to trip $tripId'); // Debug log

        return tripId;
      });
    } catch (e) {
      log('Failed to create trip: $e');
      rethrow;
    }
  }

  @override
  Future<bool> updateTripOrder(int tripId, int order) {
    return _dao.updateTripOrder(tripId, order);
  }

  @override
  Future<int> deleteTrip(int id) {
    return _dao.deleteTrip(id);
  }

  @override
  Future<Trip?> getTripById(int id) {
    return _dao.getTripById(id).then((trip) => trip?.toEntity());
  }

  @override
  Future<bool> updateTrip(Trip trip) {
    return _dao.updateTrip(trip.toData());
  }
}
