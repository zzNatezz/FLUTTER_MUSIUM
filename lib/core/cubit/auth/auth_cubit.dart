import 'package:bloc/bloc.dart';
import 'package:golobe/core/cubit/auth/auth_state.dart';
import 'package:golobe/core/repo/auth_repo.dart';
import 'dart:developer' as devlog;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart());
  final AuthRepo _authRepo = AuthRepo();
  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthProcessing());
      await _authRepo.authLogin(email: email, password: password);
      emit(AuthCompleted());
    } catch (e) {
      emit(AuthError(e.toString()));
      devlog.log('error due to --> $e');
    }
  }
}
