import 'package:flutter/material.dart';

class DeviceUtils {
  //final context = rootNavigatorKey.currentContext!;
  /// Returns true if the device is a mobile phone
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 600;
  }

  /// Returns true if the device is a tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  /// Returns true if the device is a desktop
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }
}
