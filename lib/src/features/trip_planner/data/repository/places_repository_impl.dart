import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/core/error/exceptions.dart';
import 'package:smart_travel_planner/src/core/services/network_info_service.dart';
import 'package:smart_travel_planner/src/database/dao/place_dao.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/datasource/place_data_source.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place_category.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlaceDataSource _remoteDataSource;
  final NetworkInfoService _networkInfoService;
  final PlaceDao _placeDao;

  static const minRadius = 500.0;
  static const maxRadius = 5000.0;
  static const maxPlacesPerRequest = 20;

  PlacesRepositoryImpl(
    this._remoteDataSource,
    this._networkInfoService,
    this._placeDao,
  );

  @override
  Future<List<Place>> getNearbyPlaces(
    LatLng position,
    double radius, {
    Set<PlaceCategory>? categories,
  }) async {
    try {
      if (!await _networkInfoService.isConnected) {
        final cachedPlaces = await _placeDao.getAllPlaces();

        if (cachedPlaces.isNotEmpty) {
          return cachedPlaces.map((p) => p.toEntity()).toList();
        }
        throw NetworkException('No internet connection available');
      }

      final optimizedRadius = radius.clamp(minRadius, maxRadius);

      final places = await _remoteDataSource.getNearbyPlaces(
        position.latitude,
        position.longitude,
        optimizedRadius,
        categories: categories,
      );

      await _placeDao.createPlaces(places.map((p) => p.toCompanion()).toList());

      // Limit number of places for better performance
      return places.take(maxPlacesPerRequest).toList();
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
