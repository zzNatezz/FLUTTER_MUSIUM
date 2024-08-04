import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthStart extends AuthState {}

class AuthProcessing extends AuthState {}

class AuthCompleted extends AuthState {}

class AuthError extends AuthState {
  final String error;
  const AuthError(this.error);
}
