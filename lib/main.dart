import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/login/login_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'screen/face_detection/main_page.dart';
import 'screen/todo_app/todo_home.dart';

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
      home: botToastBuilder(context, TodoHome()),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      routes: RouteConfig.routeConfigs(),
      // initialRoute: '/',
    );
  }
}
