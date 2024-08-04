import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/layout/introPage/introPage.dart';
import 'package:golobe/layout/login/login.dart';

void main() {
  runApp(MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'intro',
          builder: (BuildContext context, GoRouterState state) {
            return IntroPage();
          },
        ),
      ],
    ),
  ],
);

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Golobe',
//       home: LoginPage(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
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
