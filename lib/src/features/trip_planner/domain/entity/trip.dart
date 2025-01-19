import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    required int id,
    required String name,
    String? description,
    required DateTime startDate,
    DateTime? endDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

extension TripTableDataMapper on TripTableData {
  Trip toEntity() {
    return Trip(
      id: id,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension TripMapper on Trip {
  TripTableCompanion toCompanion() {
    return TripTableCompanion.insert(
      name: name,
      description: drift.Value(description),
      startDate: startDate,
      endDate: drift.Value(endDate),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  TripTableData toData() {
    return TripTableData(
      id: id,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}