part of 'itinerary_bloc.dart';

@freezed
class ItineraryState with _$ItineraryState {
  const factory ItineraryState.initial() = _Initial;
  const factory ItineraryState.loading() = _Loading;
  const factory ItineraryState.loaded(List<Trip> trips) = _Loaded;
  const factory ItineraryState.error(String message) = _Error;
}
