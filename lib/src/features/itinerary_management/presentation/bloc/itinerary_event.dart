part of 'itinerary_bloc.dart';

@freezed
class ItineraryEvent with _$ItineraryEvent {
  const factory ItineraryEvent.started() = _Started;
  const factory ItineraryEvent.createTrip(String name, List<Place> places) = _CreateTrip;
  const factory ItineraryEvent.deleteTrip(int id) = _DeleteTrip;
  const factory ItineraryEvent.updateTrip(Trip trip) = _UpdateTrip;  
  const factory ItineraryEvent.reorderTrips(int oldIndex, int newIndex) = _ReorderTrips;
}