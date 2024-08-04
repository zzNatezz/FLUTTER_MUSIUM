import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:golobe/layout/login/components/login_form_field.dart";
import "package:golobe/utils/assetsStorage/icon.dart";
import "package:golobe/utils/assetsStorage/picture.dart";
import 'package:golobe/utils/colorsController/colors_controller.dart';
import "package:golobe/utils/divider_with_text.dart";
import "package:golobe/utils/spaceController/spaces_controller.dart";
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  static const String loginPageRoute = '/';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Image(
                            image: AssetImage(PicturePath.logo),
                            alignment: Alignment.center,
                            width: double.infinity,
                            fit: BoxFit.fill),
                        Align(
                          alignment: const Alignment(-1, 0),
                          child: Text(
                            'Login',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const Align(
                          alignment: Alignment(-1, 0),
                          child: Text('Login to access your account',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w200)),
                        ),
                        VerticalSpace(value: 30),
                        const LoginFormField(
                          hintStyle:
                              TextStyle(color: Colorscontroller.hintTextLogin),
                        ),
                        VerticalSpace(value: 15),
                        const Text(
                          "SignUp ?",
                          style: TextStyle(
                              color: Colorscontroller.warning, fontSize: 20),
                        ),
                        VerticalSpace(value: 15),
                        Column(children: [
                          DividerWithText(
                              text: 'Or login with the others',
                              dividerColor: Colors.black,
                              fontSize: 16),
                          VerticalSpace(value: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(IconsPath.iconFb, height: 40),
                              SvgPicture.asset(IconsPath.iconGoogle,
                                  height: 40),
                              SvgPicture.asset(IconsPath.iconApple, height: 40),
                            ],
                          )
                        ]),
                        VerticalSpace(value: 30)
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
