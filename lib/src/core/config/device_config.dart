import 'dart:developer';

import 'package:flutter/material.dart';

class DeviceConfig {
  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    try {
      deviceWidth = mediaQueryData.size.width;
      deviceHeight = mediaQueryData.size.height;
    } catch (e) {
      log('DeviceConfig: deviceWidth or deviceHeight already initialized');
    }
  }

  static late final double deviceWidth;
  static late final double deviceHeight;
}
