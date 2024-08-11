import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/apiStorage/api_store.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello ${widget.user.username}', //<-- update late
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
            ), //<-- Updated Late
          ],
        )
      ],
    );
  }
}
