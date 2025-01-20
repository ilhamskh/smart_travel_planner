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
    on<_ReorderTrips>(_onReorderTrips);
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

Future<void> _onReorderTrips(_ReorderTrips event, Emitter<ItineraryState> emit) async {
  final currentState = state;
  if (currentState is! _Loaded) return;

  try {
    final trips = List<Trip>.from(currentState.trips);
    final item = trips.removeAt(event.oldIndex);
    trips.insert(event.newIndex, item);

    // Update trip order in database
    await Future.wait(
      trips.asMap().entries.map((entry) => 
        _tripRepository.updateTripOrder(entry.value.id, entry.key)
      ),
    );

    emit(ItineraryState.loaded(trips));
  } catch (e) {
    emit(ItineraryState.error(e.toString()));
  }
}
}
