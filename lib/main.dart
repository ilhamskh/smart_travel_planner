import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:smart_travel_planner/src/app/observer.dart';
import 'package:smart_travel_planner/src/injection/composition_root.dart';
import 'package:smart_travel_planner/src/injection/config.dart';

import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const config = Config();
  final compositionResult = await const CompositionRoot(config).compose();

  Bloc.observer = AppBlocObserver();

  runApp(
    TravelPlannerApp(result: compositionResult),
  );
}
