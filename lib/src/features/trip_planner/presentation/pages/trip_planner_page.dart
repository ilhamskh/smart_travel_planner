import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_travel_planner/src/core/utils/debouncer.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/place.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/bloc/trip_planner_bloc.dart';
import 'package:smart_travel_planner/src/injection/widget/dependencies_scope.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/widget/place_details_bottom_sheet.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/widget/trip_plan_bar.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/widget/categories_bottom_sheet.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  State<TripPlannerPage> createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final _searchController = TextEditingController();
  final _mapDebouncer = Debouncer(delay: Duration(milliseconds: 800));
  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/map.json')
        .then((style) => _mapStyle = style);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripPlannerBloc(
        DependenciesScope.of(context).placesRepository,
      )..add(const TripPlannerEvent.started()),
      child: BlocBuilder<TripPlannerBloc, TripPlannerState>(
        builder: (context, state) {
          final bloc = context.read<TripPlannerBloc>();
          bloc.onPlaceMarkerTap = (place) => _showPlaceDetailsBottomSheet(context, place);
          return Scaffold(
            body: state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (controller, markers, nearbyPlaces, destinations, position, lastFetch, categories, routes, isLoading) {
                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        controller.setMapStyle(_mapStyle);
                        context.read<TripPlannerBloc>().add(TripPlannerEvent.mapCreated(controller));
                      },
                      initialCameraPosition: CameraPosition(target: position, zoom: 15),
                      markers: markers,
                      polylines: routes,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onCameraMove: (position) => _onCameraMove(context, position),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SearchBar(
                                    controller: _searchController,
                                    hintText: 'Search places...',
                                    leading: const Icon(Icons.search),
                                    onSubmitted: (query) {
                                      if (query.isNotEmpty) {
                                        context.read<TripPlannerBloc>().add(
                                              TripPlannerEvent.searchPlace(
                                                  query),
                                            );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () =>
                                      _showCategoriesBottomSheet(context),
                                  icon: const Icon(Icons.filter_list),
                                ),
                              ],
                            ),
                          ),
                          if (destinations.isNotEmpty)
                            TripPlanBar(
                              destinations: destinations.values.toList(),
                              onRemoveDestination: (index) {
                                context.read<TripPlannerBloc>().add(
                                      TripPlannerEvent.removeDestination(
                                          index),
                                    );
                              },
                            ),
                        ],
                      ),
                    ),
                    if (isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
              error: (message) => Center(child: Text(message)),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapDebouncer.dispose();
    super.dispose();
  }

  void _onCameraMove(BuildContext context, CameraPosition position) {
    _mapDebouncer(() {
      if (!mounted) return;
      context.read<TripPlannerBloc>().add(
        TripPlannerEvent.cameraMoved(position.target),
      );
    });
  }

  void _showPlaceDetailsBottomSheet(BuildContext context, Place place) {
    final bloc = context.read<TripPlannerBloc>();

    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => PlaceDetailsBottomSheet(
        place: place,
        canAddDestination: bloc.canAddMoreDestinations,
        onAddDestination: () {
          bloc.add(TripPlannerEvent.addDestination(place));
          Navigator.pop(bottomSheetContext);
        },
      ),
    );
  }

  void _showCategoriesBottomSheet(BuildContext context) {
    final bloc = context.read<TripPlannerBloc>();
    
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<TripPlannerBloc, TripPlannerState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (_, __, ___, ____, _____, ______, categories, _______, ________) {
                return CategoriesBottomSheet(
                  selectedCategories: categories,
                  onCategorySelected: (category) {
                    context.read<TripPlannerBloc>().add(
                      TripPlannerEvent.toggleCategory(category),
                    );
                  },
                );
              },
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
