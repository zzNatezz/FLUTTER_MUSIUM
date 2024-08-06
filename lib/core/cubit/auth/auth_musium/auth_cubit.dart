import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devlog;

import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/core/repo/repo_auth/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart());
  final AuthRepo _authRepo = AuthRepo();
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(AuthProcessing());
      await _authRepo.authLogin(email: email, password: password);
      if (context.mounted) {
        context.pushReplacement('/intro');
      }
      emit(AuthCompleted());
    } catch (e) {
      emit(AuthError(e.toString()));
      devlog.log('error due to --> $e');
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
    } catch (e) {
      emit(AuthError(e.toString()));
      if (!context.mounted) return;
      devlog.log('Sign In GG error due to $e');
    }
  }
}
