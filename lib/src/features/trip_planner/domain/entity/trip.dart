import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_travel_planner/src/database/dao/place_dao.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    required int id,
    required String name,
    String? description,
    required List<Place> places,
    required DateTime startDate,
    DateTime? endDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

extension TripTableDataMapper on TripTableData {
  // Sync mapping without places
  Trip toEntity() {
    return Trip(
      id: id,
      name: name,
      description: description,
      places: const [], // Empty initially
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Async method to load full trip with places
  Future<Trip> toEntityWithPlaces(PlaceDao placeDao) async {
    final trip = toEntity();
    final places = await placeDao.getPlacesByTripId(id);

    return trip.copyWith(
      places: places.map((p) => p.toEntity()).toList(),
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
      displayOrder: 0,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Future<void> savePlaces(PlaceDao placeDao) async {
    await Future.wait(places.map((place) => placeDao
        .createPlace(place.toCompanion()..copyWith(tripId: drift.Value(id)))));
  }
}
