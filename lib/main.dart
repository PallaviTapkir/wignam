import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'src/core/util/navigation/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing Route Manager (AuthDatasourceLocal must be initialized before calling this)
  RouteManger.init();

  runApp(const App());
}
