import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class AuthService extends StatefulWidget {
  const AuthService({super.key});

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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colorscontroller.whitText),
                      onPressed: () {},
                      child: SvgPicture.asset(IconsPath.iconFb, height: 40)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colorscontroller.whitText),
                      onPressed: () {
                        _authCubit.SignInWithGG(context: context);
                      },
                      child:
                          SvgPicture.asset(IconsPath.iconGoogle, height: 40)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colorscontroller.whitText),
                      onPressed: () {},
                      child: SvgPicture.asset(IconsPath.iconApple, height: 40)),
                ],
              );
            }));
  }
}
