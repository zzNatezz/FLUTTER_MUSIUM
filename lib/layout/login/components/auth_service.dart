import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';

class AuthService extends StatefulWidget {
  final String iconPath;
  const AuthService({super.key, required this.iconPath});

  @override
  State<AuthService> createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = AuthCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _authCubit,
        child: BlocBuilder(
            bloc: _authCubit,
            builder: (context, state) {
              if (state is AuthProcessing) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _authCubit.SignInWithGG(context: context);
                    },
                    child: SvgPicture.asset(widget.iconPath, height: 40)),
              );
            }));
  }
}
