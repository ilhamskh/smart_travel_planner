import 'package:drift/drift.dart';
import 'dao/place_dao.dart';
import 'dao/trip_dao.dart';
import 'models/trip_table.dart';
import 'models/places_table.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    TripTable,
    PlaceTable,
  ],
  daos: [
    TripDao,
    PlaceDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}