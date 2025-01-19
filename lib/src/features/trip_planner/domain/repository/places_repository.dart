import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';

abstract interface class PlacesRepository {
  Future<List<Place>> getNearbyPlaces(
    LatLng position,
    double radius, {
    Set<PlaceCategory>? categories,
  });

  Future<Place?> getPlaceDetails(LatLng position);
  
  Future<List<Place>> searchPlaces(String query);

  Future<List<LatLng>> getRouteBetweenPoints(LatLng origin, LatLng destination);
}