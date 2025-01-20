import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dao/place_dao.dart';
import 'dao/trip_dao.dart';
import 'models/trip_table.dart';
import 'models/places_table.dart';

part 'drift_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'travel_planner.db'));
    return NativeDatabase(file);
  });
}

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
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          log('Database created');
        },
        onUpgrade: (m, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await m.addColumn(tripTable, tripTable.displayOrder);
          }
        },
      );
}
