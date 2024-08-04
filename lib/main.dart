import 'package:flutter/material.dart';
import 'package:golobe/router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = goRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Golobe',
      routerConfig: _router,
    );
  }
}
