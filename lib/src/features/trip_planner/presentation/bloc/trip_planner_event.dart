part of 'trip_planner_bloc.dart';

@freezed
class TripPlannerEvent with _$TripPlannerEvent {
  const factory TripPlannerEvent.started() = _Started;
  const factory TripPlannerEvent.mapCreated(GoogleMapController controller) = _MapCreated;
  const factory TripPlannerEvent.cameraMoved(LatLng position) = _CameraMoved;
  const factory TripPlannerEvent.toggleCategory(PlaceCategory category) = _ToggleCategory;
  const factory TripPlannerEvent.addDestination(Place place) = _AddDestination;
  const factory TripPlannerEvent.searchPlace(String query) = _SearchPlace;
  const factory TripPlannerEvent.removeDestination(int index) = _RemoveDestination;
  const factory TripPlannerEvent.clearDestinations() = _ClearDestinations;
  const factory TripPlannerEvent.recalculateRoute() = _RecalculateRoute;
  const factory TripPlannerEvent.saveTrip(String name, List<Place> places) = _SaveTrip;
}