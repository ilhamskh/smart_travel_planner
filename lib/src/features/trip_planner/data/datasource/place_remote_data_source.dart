import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/core/error/exceptions.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/datasource/place_data_source.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';

class PlaceRemoteDataSource implements PlaceDataSource {
  final Dio _dio;
  final String _apiKey;
  static const _baseUrl = 'https://places.googleapis.com/v1/places:';
  static const _fieldMask =
      'places.id,places.displayName,places.location,places.types,places.formattedAddress';

  PlaceRemoteDataSource(this._dio, this._apiKey) {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': _apiKey,
      'X-Goog-FieldMask': _fieldMask,
    };
  }

  @override
  Future<List<Place>> getNearbyPlaces(
    double lat,
    double lng,
    double radius, {
    Set<PlaceCategory>? categories,
  }) async {
    try {
      final response = await _dio.post(
        '${_baseUrl}searchNearby',
        data: {
          'locationRestriction': {
            'circle': {
              'center': {
                'latitude': lat,
                'longitude': lng,
              },
              'radius': radius,
            },
          },
          if (categories != null && categories.isNotEmpty)
            'includedTypes':
                categories.expand((cat) => cat.googlePlaceTypes).toList(),
          'maxResultCount': 20,
        },
      );

      if (response.statusCode == 200) {
        final places = (response.data['places'] as List)
            .map((place) => _mapPlaceFromJson(place))
            .toList();
        return places;
      }

      throw ServerException('Failed to load places');
    } catch (e) {
      throw ServerException('Failed to load places: $e');
    }
  }

  @override
  Future<Place?> getPlaceDetails(LatLng position) async {
    try {
      final response = await _dio.post(
        '${_baseUrl}searchNearby',
        data: {
          'locationRestriction': {
            'circle': {
              'center': {
                'latitude': position.latitude,
                'longitude': position.longitude,
              },
              'radius': 10,
            },
          },
          'maxResultCount': 1,
        },
      );

      if (response.statusCode == 200) {
        final places = response.data['places'] as List?;
        if (places != null && places.isNotEmpty) {
          return _mapPlaceFromJson(places[0]);
        }
        // Return a basic place if no details found
        return Place(
          id: 'custom_${position.latitude}_${position.longitude}',
          name: 'Selected Location',
          latitude: position.latitude,
          longitude: position.longitude,
          address: '${position.latitude}, ${position.longitude}',
          category: PlaceCategory.attraction,
        );
      }
      return null;
    } catch (e) {
      throw ServerException('Failed to get place details: $e');
    }
  }

  @override
  Future<List<Place>> searchPlaces(String query) async {
    try {
      final response = await _dio.post(
        '${_baseUrl}searchText',
        data: {
          'textQuery': query,
          'maxResultCount': 10,
        },
      );

      if (response.statusCode == 200) {
        final places = (response.data['places'] as List)
            .map((place) => _mapPlaceFromJson(place))
            .toList();
        return places;
      }
      throw ServerException('Failed to search places');
    } catch (e) {
      throw ServerException('Failed to search places: $e');
    }
  }

  Place _mapPlaceFromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['displayName']['text'] as String,
      category: _getCategoryFromTypes(json['types'] as List<dynamic>),
      latitude: json['location']['latitude'] as double,
      longitude: json['location']['longitude'] as double,
      address: json['formattedAddress'] as String?,
    );
  }

  PlaceCategory _getCategoryFromTypes(List<dynamic> placeTypes) {
    return PlaceCategory.values.firstWhere(
      (category) =>
          category.googlePlaceTypes.any((type) => placeTypes.contains(type)),
      orElse: () => PlaceCategory.attraction,
    );
  }

  @override
  Future<List<LatLng>> getRouteBetweenPoints(
      LatLng origin, LatLng destination) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
          'mode': 'walking',
        },
      );

      if (response.statusCode == 200) {
        final List<LatLng> polylinePoints = [];
        final routes = response.data['routes'] as List;

        if (routes.isNotEmpty) {
          final points = _decodePolyline(
              routes[0]['overview_polyline']['points'] as String);
          polylinePoints.addAll(points);
        }

        return polylinePoints;
      }
      throw ServerException('Failed to get route');
    } catch (e) {
      throw ServerException('Failed to get route: $e');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
