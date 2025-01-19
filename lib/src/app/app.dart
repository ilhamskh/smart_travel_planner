import 'package:flutter/material.dart';
import 'package:smart_travel_planner/src/app/router.dart';
import 'package:smart_travel_planner/src/injection/composition_root.dart';
import 'package:smart_travel_planner/src/injection/widget/dependencies_scope.dart';

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({
    super.key,
    required this.result,
  });

  final CompositionResult result;

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: result.dependencies,
      child: MaterialApp.router(
        title: "Travel Planner App",
        restorationScopeId: 'travel_planner_app',
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        routerConfig: AppRouter.router,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
