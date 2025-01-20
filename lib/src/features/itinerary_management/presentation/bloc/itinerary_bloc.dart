import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/repository/trip_repository.dart';

part 'itinerary_event.dart';
part 'itinerary_state.dart';
part 'itinerary_bloc.freezed.dart';

class ItineraryBloc extends Bloc<ItineraryEvent, ItineraryState> {
  final TripRepository _tripRepository;

  ItineraryBloc(this._tripRepository) : super(const ItineraryState.initial()) {
    on<_Started>(_onStarted);
    on<_CreateTrip>(_onCreateTrip);
    on<_DeleteTrip>(_onDeleteTrip);
    on<_UpdateTrip>(_onUpdateTrip);
    on<_ReorderPlaces>(_onReorderPlaces);
  }

  Future<void> _onStarted(_Started event, Emitter<ItineraryState> emit) async {
    emit(const ItineraryState.loading());
    try {
      final trips = await _tripRepository.getAllTrips();
      emit(ItineraryState.loaded(trips));
    } catch (e) {
      emit(ItineraryState.error(e.toString()));
    }
  }

  Future<void> _onCreateTrip(_CreateTrip event, Emitter<ItineraryState> emit) async {
    emit(const ItineraryState.loading());
    try {
      final trip = Trip(
        id: 0,
        name: event.name,
        places: event.places,
        startDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _tripRepository.createTrip(trip);
      add(const ItineraryEvent.started());
    } catch (e) {
      emit(ItineraryState.error(e.toString()));
    }
  }

  Future<void> _onDeleteTrip(_DeleteTrip event, Emitter<ItineraryState> emit) async {
    try {
      await _tripRepository.deleteTrip(event.id);
      add(const ItineraryEvent.started());
    } catch (e) {
      emit(ItineraryState.error(e.toString()));
    }
  }

  Future<void> _onUpdateTrip(_UpdateTrip event, Emitter<ItineraryState> emit) async {
    try {
      await _tripRepository.updateTrip(event.trip);
      add(const ItineraryEvent.started());
    } catch (e) {
      emit(ItineraryState.error(e.toString()));
    }
  }

  Future<void> _onReorderPlaces(_ReorderPlaces event, Emitter<ItineraryState> emit) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    try {
      final trip = currentState.trips.firstWhere((t) => t.id == event.tripId);
      final places = List<Place>.from(trip.places);
      final item = places.removeAt(event.oldIndex);
      places.insert(event.newIndex, item);

      await _tripRepository.updateTrip(trip.copyWith(places: places));
      add(const ItineraryEvent.started());
    } catch (e) {
      emit(ItineraryState.error(e.toString()));
    }
  }
}
