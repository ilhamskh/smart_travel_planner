import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:smart_travel_planner/src/database/models/trip_table.dart';
import '../drift_database.dart';

part 'trip_dao.g.dart';

@DriftAccessor(tables: [TripTable])
class TripDao extends DatabaseAccessor<AppDatabase> with _$TripDaoMixin {
  TripDao(super.db);

  Future<List<TripTableData>> getAllTrips() async {
    try {
      final trips = await (select(tripTable)
        ..orderBy([(t) => OrderingTerm(expression: t.displayOrder)]))
        .get();
      log('Found ${trips.length} trips in database');
      return trips;
    } catch (e) {
      log('Error getting all trips: $e');
      rethrow;
    }
  }

  Stream<List<TripTableData>> watchAllTrips() => select(tripTable).watch();

  Future<TripTableData?> getTripById(int id) =>
      (select(tripTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> createTrip(TripTableCompanion trip) async {
    try {
      final id = await into(tripTable).insert(trip);
      log('Created trip with id: $id');
      return id;
    } catch (e) {
      log('Error creating trip: $e');
      rethrow;
    }
  }

  Future<bool> updateTrip(TripTableData trip) =>
      update(tripTable).replace(trip);

  Future<bool> updateTripOrder(int id, int order) async {
    try {
      final updatedRows = await (update(tripTable)
            ..where((t) => t.id.equals(id)))
          .write(TripTableCompanion(
        displayOrder: Value(order),
        updatedAt: Value(DateTime.now()),
      ));
      log('Updated trip $id order to $order');
      return updatedRows > 0;
    } catch (e) {
      log('Error updating trip order: $e');
      rethrow;
    }
  }

  Future<int> deleteTrip(int id) =>
      (delete(tripTable)..where((t) => t.id.equals(id))).go();
}
