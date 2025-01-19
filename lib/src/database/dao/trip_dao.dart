import 'package:drift/drift.dart';
import 'package:smart_travel_planner/src/database/models/trip_table.dart';
import '../drift_database.dart';

part 'trip_dao.g.dart';

@DriftAccessor(tables: [TripTable])
class TripDao extends DatabaseAccessor<AppDatabase> with _$TripDaoMixin {
  TripDao(super.db);

  Future<List<TripTableData>> getAllTrips() => select(tripTable).get();

  Stream<List<TripTableData>> watchAllTrips() => select(tripTable).watch();

  Future<TripTableData?> getTripById(int id) =>
      (select(tripTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> createTrip(TripTableCompanion trip) =>
      into(tripTable).insert(trip);

  Future<bool> updateTrip(TripTableData trip) =>
      update(tripTable).replace(trip);

  Future<int> deleteTrip(int id) =>
      (delete(tripTable)..where((t) => t.id.equals(id))).go();
}