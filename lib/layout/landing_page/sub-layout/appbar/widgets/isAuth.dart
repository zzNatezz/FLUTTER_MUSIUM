import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class AuthedState extends StatelessWidget {
  final LoginEntity? user;
  const AuthedState({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back !!!',
              style: TextStyle(color: Colorscontroller.whitText, fontSize: 18),
            ),
            Text(
              '${user?.username}',
              style: const TextStyle(
                  color: Colorscontroller.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              IconsPath.bell,
              height: 30,
            ),
            HorizontalSpace(value: 10),
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  user?.avatar as String,
                  height: 40,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return SvgPicture.asset(IconsPath.defaultAvatar,
                        height: 40);
                  },
                )),
          ],
        )
      ],
    );
  }
}
