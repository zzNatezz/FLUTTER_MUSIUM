import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/core/cubit/auth/auth_state.dart';
import 'package:golobe/core/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInit());

  final AuthRepo _authRepo = AuthRepo();

  Future<void> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      emit(AuthLoading());
      final result =
          await _authRepo.authLogin(email: email, password: password);

      print(result);

      context.push('/intro');
    } catch (e) {}
  }
}
//!D/EGL_emulation
