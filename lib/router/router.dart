import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/layout/introPage/introPage.dart';
import 'package:golobe/layout/login/login.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(
        path: LoginPage.loginPageRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: IntroPage.IntroPageRoute,
            builder: (BuildContext context, GoRouterState state) =>
                const IntroPage(),
          )
        ])
  ]);
}
