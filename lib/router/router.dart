import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'package:golobe/layout/landing_page/components/appbar_title.dart';
import 'package:golobe/layout/landing_page/landing_page.dart';
import 'package:golobe/layout/login/login.dart';
import 'package:golobe/layout/sign_up/sign_up.dart';


GoRouter goRouter() {
  return GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(
        path: LandingPage.landingPageRoute,
        builder: (BuildContext context, GoRouterState state) {
          return  LandingPage();},
        routes: <RouteBase>[
          GoRoute(
            name: AppbarTitle.appBarRoute,
              path: AppbarTitle.appBarRoute,
              pageBuilder: (BuildContext context, GoRouterState state) {
              return MaterialPage( fullscreenDialog: true, child: AppbarTitle(user: state.extra as LoginEntity));
              }),
          GoRoute(
              name: LoginPage.loginPageRoute,
              path: LoginPage.loginPageRoute,
              builder: (BuildContext context, GoRouterState state) {
                return const LoginPage();
              })],
    ),
    GoRoute(
      name: RegisterPage.registerPageRoute,
      path: '/${RegisterPage.registerPageRoute}',
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterPage(),
    ),
  ]);
}
