import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/apiStorage/api_store.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_state.dart';
import 'package:golobe/layout/login/login.dart';

import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class AppbarTitle extends StatefulWidget {
  final LoginEntity user;
  const AppbarTitle({super.key, required this.user});

  @override
  State<AppbarTitle> createState() => _AppbarTitleState();
}

class _AppbarTitleState extends State<AppbarTitle> {
  late AuthCubit _authCubit;

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
            if (state is AuthCompleted) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello ${widget.user.username}',
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
                        widget.user.avatar == null
                            ? IconsPath.defaultAvatar
                            : widget.user.avatar.toString(),
                        height: 40,
                      )
                    ],
                  )
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SẼ update cập nhật thời tiết các kiểu ở đây', //<-- update late
                    style: TextStyle(color: Colorscontroller.whitText),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconsPath.bell,
                        height: 30,
                      ),
                      HorizontalSpace(value: 10),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(LoginPage.loginPageRoute);
                          },
                          child: const Text('Login'))
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}
