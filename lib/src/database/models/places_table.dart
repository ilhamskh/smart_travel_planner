import 'package:drift/drift.dart';

class PlaceTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get address => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}