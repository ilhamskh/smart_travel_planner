import 'package:flutter/material.dart';
import 'package:smart_travel_planner/src/injection/composition_root.dart';
import 'package:smart_travel_planner/src/injection/config.dart';

import 'src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const config = Config();
  final compositionResult = await const CompositionRoot(config).compose();

  runApp(
    TravelPlannerApp(result: compositionResult),
  );
}
