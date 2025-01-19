import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/core/error/exceptions.dart';
import 'package:smart_travel_planner/src/core/services/network_info_service.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/datasource/place_data_source.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlaceDataSource _remoteDataSource;
  final NetworkInfoService _networkInfoService;
  
  final _viewportCache = <String, List<Place>>{};
  static const _maxPlacesPerViewport = 30;
  static const _gridPrecision = 3;

  PlacesRepositoryImpl(
    this._remoteDataSource,
    this._networkInfoService,
  );

  @override
  Future<List<Place>> getNearbyPlaces(
    LatLng position,
    double radius, {
    Set<PlaceCategory>? categories,
  }) async {
    try {
      if (!await _networkInfoService.isConnected) {
        throw NetworkException('No internet connection available');
      }

      final viewportKey = _generateViewportKey(position, radius);

      if (_viewportCache.containsKey(viewportKey)) {
        return _viewportCache[viewportKey]!;
      }

      final places = await _remoteDataSource.getNearbyPlaces(
        position.latitude,
        position.longitude,
        radius,
        categories: categories,
      );

      if (places.isEmpty) {
        throw NoPlacesFoundException();
      }

      final nearestPlaces = _getNearestPlaces(places, position);
      _viewportCache[viewportKey] = nearestPlaces;

      return nearestPlaces;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Place?> getPlaceDetails(LatLng position) async {
    try {
      if (!await _networkInfoService.isConnected) {
        throw NetworkException('No internet connection available');
      }

      return await _remoteDataSource.getPlaceDetails(position);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Place>> searchPlaces(String query) async {
    try {
      if (!await _networkInfoService.isConnected) {
        throw NetworkException('No internet connection available');
      }

      return await _remoteDataSource.searchPlaces(query);
    } catch (e) {
      rethrow;
    }
  }

  String _generateViewportKey(
    LatLng position,
    double radius,
  ) {
    final lat = position.latitude.toStringAsFixed(_gridPrecision);
    final lng = position.longitude.toStringAsFixed(_gridPrecision);
    return '$lat:$lng:$radius';
  }

  List<Place> _getNearestPlaces(List<Place> places, LatLng center) {
    return places
      ..sort((a, b) {
        final distA = _calculateDistance(
          center,
          LatLng(a.latitude, a.longitude),
        );
        final distB = _calculateDistance(
          center,
          LatLng(b.latitude, b.longitude),
        );
        return distA.compareTo(distB);
      })
      ..take(_maxPlacesPerViewport).toList();
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const earthRadius = 6371000; // meters
    final lat1 = from.latitude * pi / 180;
    final lat2 = to.latitude * pi / 180;
    final dLat = (to.latitude - from.latitude) * pi / 180;
    final dLon = (to.longitude - from.longitude) * pi / 180;

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
  
  @override
  Future<List<LatLng>> getRouteBetweenPoints(
    LatLng origin,
    LatLng destination,
  ) async {
    if (!await _networkInfoService.isConnected) {
      throw NetworkException('No internet connection available');
    }
    return _remoteDataSource.getRouteBetweenPoints(origin, destination);
  }
}
