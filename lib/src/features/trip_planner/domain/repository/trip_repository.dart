import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';

abstract interface class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(int id);
  Future<int> createTrip(Trip trip);
  Future<bool> updateTrip(Trip trip);
  Future<int> deleteTrip(int id);
}