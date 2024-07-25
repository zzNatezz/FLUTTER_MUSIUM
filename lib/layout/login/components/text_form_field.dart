import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/all_functions/fnc_login.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class LoginFormField extends StatefulWidget {
  final TextStyle hintStyle;

  const LoginFormField(
      {super.key, this.hintStyle = const TextStyle(color: Colors.grey)});

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isObs = true;
  void obsController() {
    setState(() {
      isObs = !isObs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: 'E-mail or user name',
              hintStyle: widget.hintStyle,
              border: const OutlineInputBorder()),
        ),
        VerticalSpace(value: 15),
        TextFormField(
          controller: _passwordController,
          obscureText: isObs,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Password here",
            hintStyle: widget.hintStyle,
            suffixIconConstraints:
                const BoxConstraints(minHeight: 10, maxHeight: 50),
            suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onTap: () {
                  obsController();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Ink(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      isObs ? IconsPath.eyeClosed : IconsPath.eye,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        VerticalSpace(value: 15),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colorscontroller.loginButton),
            onPressed: () {
              loginFnc(
                  email: _emailController.text,
                  password: _passwordController.text);
            },
            child: Text('Login',
                style: TextStyle(
                    color: Colorscontroller.whitText,
                    fontSize: 30,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
