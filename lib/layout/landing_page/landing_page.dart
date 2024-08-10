import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class LandingPage extends StatelessWidget {
  static const landingPageRoute = 'landing';
  final AuthCubit authCubit = AuthCubit();
  LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hello', //<-- update late
              style: TextStyle(color: Colorscontroller.whitText),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  IconsPath.bell,
                  height: 30,
                ),
                HorizontalSpace(value: 10),
                SvgPicture.asset(
                  IconsPath.defaultAvatar,
                  height: 40,
                ), //<-- Updated Late
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                authCubit.Logout(context: context);
              },
              child: const Text('LogOut temporary'))
        ],
      ),
    );
  }
}
