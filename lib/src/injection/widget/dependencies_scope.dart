import 'package:flutter/material.dart';
import 'package:smart_travel_planner/src/database/drift_database.dart';
import 'package:smart_travel_planner/src/injection/global/dependencies_container.dart';

class DependenciesScope extends InheritedWidget {

  const DependenciesScope({
    required this.dependencies,
    required super.child,
    super.key,
  });


  final DependenciesContainer dependencies;

  static DependenciesContainer of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<DependenciesScope>()!.dependencies;

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
