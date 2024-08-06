import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golobe/router/router.dart';
import 'package:golobe/utils/fire-base/StoreDataFb.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Musium',
      routerConfig: _router,
    );
  }
}
