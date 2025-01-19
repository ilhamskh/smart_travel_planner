import 'package:go_router/go_router.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/pages/home_page.dart';
import 'package:smart_travel_planner/src/features/trip_planner/presentation/pages/trip_planner_page.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        name: 'home',
      ),
      GoRoute(
        path: '/trip-planner',
        builder: (context, state) => const TripPlannerPage(),
        name: 'trip-planner',
      ),
    ],
  );
}
