part of 'trip_planner_bloc.dart';

@freezed
class TripPlannerState with _$TripPlannerState {
  const factory TripPlannerState.initial() = _Initial;
  const factory TripPlannerState.loading() = _Loading;
  const factory TripPlannerState.loaded({
    GoogleMapController? mapController,
    required Set<Marker> markers,
    required Map<String, Place> nearbyPlacesMap,
    required Map<String, Place> destinationsMap,
    required LatLng initialPosition,
    LatLng? lastFetchPosition,
    @Default({}) Set<PlaceCategory> selectedCategories,
    @Default({}) Set<Polyline> routes,
    @Default(false) bool isLoading,
  }) = _Loaded;
  const factory TripPlannerState.error(String message) = _Error;
}