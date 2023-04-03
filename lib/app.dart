import 'package:flutter/material.dart';
import 'package:wignam/src/core/navigation_service.dart';

import 'src/core/config/device_config.dart';
import 'src/core/util/navigation/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          ///This method [DeviceConfig.init] is called here as it initializes the device config values
          ///such as sizes and more
          DeviceConfig.init(context);
          return child!;
        },
        home: Router(
            routerDelegate: RouteManger.instance,
            backButtonDispatcher: RootBackButtonDispatcher()));
  }
}
