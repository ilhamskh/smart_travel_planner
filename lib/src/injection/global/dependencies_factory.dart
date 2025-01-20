import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logging/logging.dart';
import 'package:smart_travel_planner/src/core/services/network_info_service.dart';
import 'package:smart_travel_planner/src/core/utils/logging_interceptor.dart';
import 'package:smart_travel_planner/src/database/dao/place_dao.dart';
import 'package:smart_travel_planner/src/database/dao/trip_dao.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/datasource/place_remote_data_source.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/repository/places_repository_impl.dart';
import 'package:smart_travel_planner/src/features/trip_planner/data/repository/trip_repository_impl.dart';
import 'package:smart_travel_planner/src/injection/config.dart';
import 'package:smart_travel_planner/src/injection/factories.dart';
import 'package:smart_travel_planner/src/injection/global/dependencies_container.dart';

class GlobalDependenciesFactory extends Factory<DependenciesContainer> {
  final Config config;

  GlobalDependenciesFactory(this.config);

  @override
  DependenciesContainer create() {
    try {
      final client = Dio(
        BaseOptions(
          baseUrl: 'https://maps.googleapis.com/maps/api',
          headers: {'Content-Type': 'application/json'},
        ),
      )..interceptors.add(DioLoggingInterceptor());
      
      final connectionChecker = InternetConnectionChecker.instance;
      final networkInfoService = NetworkInfoService(connectionChecker);
      
      final placeDataSource = PlaceRemoteDataSource(
        client,
        config.googleMapsApiKey,
      );

      final database = AppDatabase();

      final placeDao = PlaceDao(database);

      final placesRepository = PlacesRepositoryImpl(
        placeDataSource,
        networkInfoService,
        placeDao,
      );

      final tripRepository = TripRepositoryImpl(
        TripDao(database),
        placeDao,
      );

      return DependenciesContainer(
        dioClient: client,
        networkInfoService: networkInfoService,
        placesRepository: placesRepository,
        tripRepository: tripRepository,
        appDatabase: database,
      );
    } catch (e, stackTrace) {
      Logger('DependenciesFactory')
          .severe('Failed to create dependencies', e, stackTrace);
      rethrow;
    }
  }
}
