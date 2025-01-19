import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'place_category.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    String? address,
    String? description,
    String? imageUrl,
    @Default(false) bool isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

extension PlaceTableDataMapper on PlaceTableData {
  Place toEntity() {
    return Place(
      id: id,
      name: name,
      category: PlaceCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == category.toLowerCase(),
        orElse: () => PlaceCategory.attraction,
      ),
      latitude: latitude,
      longitude: longitude,
      description: description,
      imageUrl: imageUrl,
      address: address,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension PlaceMapper on Place {
  PlaceTableCompanion toCompanion() {
    return PlaceTableCompanion.insert(
      id: id,
      name: name,
      category: category.name,
      latitude: latitude,
      longitude: longitude,
      description: drift.Value(description),
      imageUrl: drift.Value(imageUrl),
      address: drift.Value(address),
      isFavorite: drift.Value(isFavorite),
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  PlaceTableData toData() {
    return PlaceTableData(
      id: id,
      name: name,
      category: category.name,
      latitude: latitude,
      longitude: longitude,
      description: description,
      imageUrl: imageUrl,
      address: address,
      isFavorite: isFavorite,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

