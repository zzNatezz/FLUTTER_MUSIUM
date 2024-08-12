import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/layout/login/login.dart';
import 'dart:developer' as dev;
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class AppbarTitle extends StatefulWidget {
  static const String appBarRoute = 'appbar';
  final LoginEntity? user;
  const AppbarTitle({super.key, this.user});

  @override
  State<AppbarTitle> createState() => _AppbarTitleState();
}

class _AppbarTitleState extends State<AppbarTitle> {
  late AuthCubit _authCubit;
  late LoginEntity? _isUser;
  @override
  void initState() {
    _isUser = widget.user;
    _authCubit = AuthCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => _authCubit,
    //   child: BlocBuilder(
    //       bloc: _authCubit,
    //       builder: (context, state) {
    //         if (state is AuthCompleted) {
    //           return Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'Hello ${widget.user.username}',
    //                 style: const TextStyle(color: Colorscontroller.whitText),
    //               ),
    //               Row(
    //                 children: [
    //                   SvgPicture.asset(
    //                     IconsPath.bell,
    //                     height: 30,
    //                   ),
    //                   HorizontalSpace(value: 10),
    //                   SvgPicture.asset(
    //                     widget.user.avatar == null
    //                         ? IconsPath.defaultAvatar
    //                         : widget.user.avatar.toString(),
    //                     height: 40,
    //                   )
    //                 ],
    //               )
    //             ],
    //           );
    //         }
    //           return Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               const Text(
    //                 'Weather updated latey', //<-- update late
    //                 style: TextStyle(color: Colorscontroller.whitText),
    //               ),
    //                   TextButton(
    //                       onPressed: () {
    //                         // context.pushNamed(LoginPage.loginPageRoute);
    //                         dev.log(widget.user.username.toString());
    //                       },
    //                       child: const Text('Login'))
    //             ],
    //           );
    //         }
    //       ),
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello ${widget.user?.username}',
          style: const TextStyle(color: Colorscontroller.whitText),
        ),
        Row(
          children: [
            SvgPicture.asset(
              IconsPath.bell,
              height: 30,
            ),
            HorizontalSpace(value: 10),
            SvgPicture.asset(
              widget.user?.avatar == null
                  ? IconsPath.defaultAvatar
                  : widget.user!.avatar.toString(),
              height: 40,
            )
          ],
        )
      ],
    );
  }
}
