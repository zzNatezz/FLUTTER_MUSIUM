import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/layout/landing_page/landing_page.dart';
import 'package:golobe/layout/login/login.dart';
import 'package:golobe/layout/sign_up/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(
        path: LandingPage.landingPageRoute,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final LoginEntity? isUser = state.extra as LoginEntity?;
          return MaterialPage(
              child: BlocProvider(
                create: (context) => SongEmitCubit(),
                child: LandingPage(user: isUser),
              ),
              fullscreenDialog: true);
        }),
    GoRoute(
        name: LoginPage.loginPageRoute,
        path: "/${LoginPage.loginPageRoute}",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        }),
    GoRoute(
      name: RegisterPage.registerPageRoute,
      path: '/${RegisterPage.registerPageRoute}',
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterPage(),
    ),
  ]);
}
