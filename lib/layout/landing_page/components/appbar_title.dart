import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/layout/login/login.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class AppbarTitle extends StatefulWidget {
  final LoginEntity? user;
  const AppbarTitle({super.key, this.user});

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
    if (widget.user != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back !!!',
                style:
                    TextStyle(color: Colorscontroller.whitText, fontSize: 18),
              ),
              Text(
                '${widget.user?.username}',
                style: const TextStyle(
                    color: Colorscontroller.black26,
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
                    widget.user?.avatar as String,
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Update weather late',
          style: TextStyle(color: Colorscontroller.whitText),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colorscontroller.whitText),
            onPressed: () {
              context.go('/${LoginPage.loginPageRoute}');
            },
            child: const Text(
              'Login',
              style: (TextStyle(color: Colorscontroller.blue, fontSize: 18)),
            ))
      ],
    );
  }
}
