import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_travel_planner/src/app/scaffold_with_navbar.dart';
import 'package:smart_travel_planner/src/features/itinerary_management/presentation/pages/itinerary_page.dart';
import 'package:smart_travel_planner/src/features/itinerary_management/presentation/pages/trip_map_page.dart';
import 'package:smart_travel_planner/src/features/trip_planner/domain/entity/trip.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/pages/home_page.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/pages/trip_planner_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/itinerary',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ItineraryPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/trip-map',
        builder: (context, state) => TripMapPage(
          trip: state.extra as Trip,
        ),
      ),
      GoRoute(
        path: '/trip-planner',
        builder: (context, state) => TripPlannerPage(),
      ),
    ],
  );
}
