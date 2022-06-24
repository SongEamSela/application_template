import 'dart:io';
import 'package:flutter/foundation.dart';

enum DevicePlatform { web, android, ios, macOS, window, linux, unknow }

class PlatformGatewayChecker {
  static DevicePlatform platformChecker() {
    if (kIsWeb) {
      return DevicePlatform.web;
    } else {
      if (Platform.isAndroid) {
        return DevicePlatform.android;
      } else if (Platform.isIOS) {
        return DevicePlatform.ios;
      } else if (Platform.isLinux) {
        return DevicePlatform.linux;
      } else if (Platform.isMacOS) {
        return DevicePlatform.macOS;
      } else if (Platform.isWindows) {
        return DevicePlatform.window;
      } else {
        return DevicePlatform.unknow;
      }
    }
  }
}
