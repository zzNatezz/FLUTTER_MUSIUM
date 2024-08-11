import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
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
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage(
                      fullscreenDialog: true,
                      child: LandingPage(user: state.extra as LoginEntity))),
        ]),
    GoRoute(
      path: RegisterPage.registerPageRoute,
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterPage(),
    ),
  ]);
}
