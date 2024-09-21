import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golobe/router/router.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/fire-base/storeDataFb.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: FireBaseOption.apiKey,
          appId: FireBaseOption.appId,
          messagingSenderId: FireBaseOption.messagingSenderId,
          projectId: FireBaseOption.projectId));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = goRouter();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          scaffoldBackgroundColor: Colorscontroller.PrimaryBackground),
      title: 'Musium',
      routerConfig: _router,
    );
  }
}
