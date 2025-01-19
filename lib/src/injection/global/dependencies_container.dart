import 'package:dio/dio.dart';
import 'package:smart_travel_planner/src/core/services/network_info_service.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/places_repository.dart';

base class DependenciesContainer {
  const DependenciesContainer({
    required this.dioClient,
    required this.networkInfoService,
    required this.placesRepository,
    required this.appDatabase,
  });

  final Dio dioClient;
  final NetworkInfoService networkInfoService;
  final PlacesRepository placesRepository;
  final AppDatabase appDatabase;
}