import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/layout/landing_page/landing_page.dart';
import 'package:golobe/layout/login/login.dart';
import 'package:golobe/layout/sign_up/sign_up.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(
        path: LoginPage.loginPageRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: LandingPage.landingPageRoute,
            builder: (BuildContext context, GoRouterState state) =>
                LandingPage(),
          ),
        ]),
    GoRoute(
      path: RegisterPage.registerPageRoute,
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterPage(),
    ),
  ]);
}
