import 'dart:developer' as devlog;

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/core/repo/repo_auth/auth_repo.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/auth_exept.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/gg_exept.dart';
import 'package:golobe/layout/landing_page/landing_page.dart';
import 'package:golobe/layout/login/login.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart());
  final AuthRepo _authRepo = AuthRepo();
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(AuthProcessing());
      final LoginEntity authen =
          await _authRepo.authLogin(email: email, password: password);
      if (authen.error == true) {
        throw Exception('Incorrect user name and password');
      }
      emit(AuthCompleted());
      if (context.mounted) {
        context.pushReplacement(LandingPage.routerConfig, extra: authen);
      }
    } on Exception catch (e) {
      emit(AuthCompleted());
      AlerException(mess: e.toString()).AlertAuth(context: context);
    } catch (e) {
      emit(AuthError());
      devlog.log('UnExpect Error for Dev :) --> $e');
    }
  }

  //Google
  Future<void> SignInWithGG({required BuildContext context}) async {
    try {
      emit(AuthProcessing());
      final UserCredential authResult = await _authRepo.signInWithGoogle();
      final User? user = authResult.user;
      final LoginEntity authen = LoginEntity(
          username: user?.displayName,
          email: user?.email,
          id: user?.uid,
          avatar: user?.photoURL as String);
      if (context.mounted) {
        context.pushReplacement(LandingPage.routerConfig, extra: authen);
      }
    } on NoGoogleAccountChosenException {
      emit(AuthError());
      return;
    } catch (e) {
      emit(AuthError());
      if (!context.mounted) return;
      devlog.log('Sign In GG error due to --> $e');
    }
  }

  Future<void> Logout({required BuildContext context}) async {
    try {
      await _authRepo.logOut();
      if (context.mounted) {
        context.pushReplacement('/${LoginPage.routerConfig}');
      }
      emit(AuthCompleted());
    } catch (e) {
      devlog.log('Sever Error....');
    }
  }
}
