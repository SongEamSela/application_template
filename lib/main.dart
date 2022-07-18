import 'package:application_template/android_platform/android_main.dart';
import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/initial_screen.dart';
import 'package:application_template/ios_platform/ios_main.dart';
import 'package:application_template/linux_platform/linux_main.dart';
import 'package:application_template/mac_platform/mac_main.dart';
import 'package:application_template/platform_gateway_checker.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/shared_widgets/unknow_platform.dart';
import 'package:application_template/web_platform/web_main.dart';
import 'package:application_template/window_platform/window_main.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'screen/face_detection/main_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: 'AIzaSyAmoV2lseD4f8ErZwVHMa_nuZqMSAKqStc',
      //     appId: '1:35887417823:web:19a87aacebadabf6405c6a',
      //     messagingSenderId: '35887417823',
      //     projectId: 'template-99787'),
      );

  runApp(Phoenix(child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'Flutter Demo',

      //theme
      themeMode: ThemeMode.light,
      theme: ThemeConstant.light,
      home: botToastBuilder(context, MainPage()),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      routes: RouteConfig.routeConfigs(),
      // initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _platformChecker();
  }

  _platformChecker() {
    DevicePlatform device = PlatformGatewayChecker.platformChecker();
    switch (device) {
      case DevicePlatform.web:
        return const WebMain();
      case DevicePlatform.android:
        return const AndroidMain();
      case DevicePlatform.ios:
        return const IOSMian();
      case DevicePlatform.macOS:
        return const MacMain();
      case DevicePlatform.window:
        return const WindowMain();
      case DevicePlatform.linux:
        return const LinuxMain();
      case DevicePlatform.unknow:
        return const UnknowPlatform();
    }
  }
}
