import 'package:smart_travel_planner/src/database/dao/trip_dao.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripDao _dao;

  TripRepositoryImpl(this._dao);

  @override
  Future<List<Trip>> getAllTrips() async {
    final trips = await _dao.getAllTrips();
    return trips.map((trip) => trip.toEntity()).toList();
  }
  
  @override
  Future<int> createTrip(Trip trip) {
    return _dao.createTrip(trip.toCompanion());
  }
  
  @override
  Future<int> deleteTrip(int id) {
    return _dao.deleteTrip(id);
  }
  
  @override
  Future<Trip?> getTripById(int id) {
    return _dao.getTripById(id).then((trip) => trip?.toEntity());
  }
  
  @override
  Future<bool> updateTrip(Trip trip) {
    return _dao.updateTrip(trip.toData());
  }
  
}
