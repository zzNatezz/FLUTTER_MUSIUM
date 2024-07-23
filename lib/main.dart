import 'package:flutter/material.dart';
import 'package:golobe/layout/introPage/introPage.dart';
import 'package:golobe/layout/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golobe',
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/intro': (context) => IntroPage()
      },
    );
  }
}
