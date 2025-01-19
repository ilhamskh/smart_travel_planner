import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:smart_travel_planner/src/injection/config.dart';
import 'package:smart_travel_planner/src/injection/global/dependencies_container.dart';

import 'global/dependencies_factory.dart';

final class CompositionRoot {
  const CompositionRoot(this.config);

  final Config config;

  Future<CompositionResult> compose() async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrintThrottled(
        '${record.level.name}: ${record.time}: ${record.message}',
      );
    });

    final stopwatch = clock.stopwatch()..start();
    final logger = Logger('CompositionRoot compose');

    //Initialize Global Dependencies
    logger.info('Initializing Global Dependencies...');
    final globalDependencies = GlobalDependenciesFactory(config).create();
    stopwatch.stop();
    logger.finest('Global Dependencies initialized in ${stopwatch.elapsed}');

    final result = CompositionResult(
      dependencies: globalDependencies
    );

    return result;
  }
}

class CompositionResult {
  const CompositionResult(
    {required this.dependencies}
  );

  final DependenciesContainer dependencies;
}