import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:smart_travel_planner/src/database/models/places_table.dart';
import '../drift_database.dart';

part 'place_dao.g.dart';

@DriftAccessor(tables: [PlaceTable])
class PlaceDao extends DatabaseAccessor<AppDatabase> with _$PlaceDaoMixin {
  PlaceDao(super.db);

  Future<List<PlaceTableData>> getAllPlaces() => select(placeTable).get();
  Future<List<PlaceTableData>> getPlacesByTripId(int tripId) async {
    try {
      return await (select(placeTable)
            ..where((p) => p.tripId.equals(tripId))
            ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
          .get();
    } catch (e) {
      log('Error getting places for trip $tripId: $e');
      rethrow;
    }
  }

  Stream<List<PlaceTableData>> watchAllPlaces() => select(placeTable).watch();

  Future<PlaceTableData?> getPlaceById(String id) =>
      (select(placeTable)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<PlaceTableData>> getPlacesByCategory(String category) =>
      (select(placeTable)..where((p) => p.category.equals(category))).get();

  Future<int> createPlace(PlaceTableCompanion place) async {
    try {
      return await into(placeTable).insert(place);
    } catch (e) {
      log('Error creating place: $e');
      rethrow;
    }
  }

  Future<void> createPlaces(List<PlaceTableCompanion> places) async {
    await batch((batch) {
      for (var place in places) {
        batch.insert(placeTable, place);
      }
    });
  }


  Future<bool> updatePlace(PlaceTableData place) =>
      update(placeTable).replace(place);

  Future<int> deletePlace(String id) =>
      (delete(placeTable)..where((p) => p.id.equals(id))).go();

  Future<List<PlaceTableData>> searchPlaces(String query) =>
      (select(placeTable)..where((p) => p.name.like('%$query%'))).get();
}
