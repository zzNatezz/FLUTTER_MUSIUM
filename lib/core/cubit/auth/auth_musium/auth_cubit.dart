import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'dart:developer' as devlog;
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/core/repo/repo_auth/auth_repo.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/auth_exept.dart';
import 'package:golobe/core/repo/repo_auth/exceptions/gg_exept.dart';
import 'package:golobe/layout/landing_page/landing_page.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart());
  final AuthRepo _authRepo = AuthRepo();
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(AuthProcessing());
      if (email.isEmpty || password.isEmpty) {
        throw Exception("User name and password can't be empty");
      }
      if (email.length < 5) {
        throw Exception("User name is too short");
      }
      final authen =
          await _authRepo.authLogin(email: email, password: password);
      if (authen.error == true) {
        throw Exception('Incorrect user name and password');
      }
      if (context.mounted) {
        context.pushReplacement('/${LandingPage.landingPageRoute}');
      }
      emit(AuthCompleted());
    } on Exception catch (e) {
      emit(AuthCompleted());
      AlerException(mess: e.toString()).AlertAuth(context: context);
    } catch (e) {
      emit(AuthError(e.toString()));
      devlog.log('Un Expect Error for Dev :) --> $e');
    }
  }

  //Google

  Future<void> SignInWithGG({required BuildContext context}) async {
    try {
      emit(AuthProcessing());
      await _authRepo.signInWithGoogle();
      if (context.mounted) {
        context.pushReplacement('/intro');
      }
    } on NoGoogleAccountChosenException {
      emit(AuthCompleted());
      return;
    } catch (e) {
      emit(AuthError(e.toString()));
      if (!context.mounted) return;
      devlog.log('Sign In GG error due to $e');
    }
  }

  Future<void> Logout({required BuildContext context}) async {
    try {
      await _authRepo.logOut();
      if (context.mounted) {
        context.pushReplacement('/');
      }
    } catch (e) {
      devlog.log('Sever errorrss....');
    }
  }
}
