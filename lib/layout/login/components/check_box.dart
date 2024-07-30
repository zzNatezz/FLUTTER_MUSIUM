import 'package:flutter/material.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class LoginCheckBox extends StatefulWidget {
  const LoginCheckBox({super.key});

  @override
  State<LoginCheckBox> createState() => _LoginCheckBoxState();
}

class _LoginCheckBoxState extends State<LoginCheckBox> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        checkColor: Colorscontroller.whitText,
        value: isCheck,
        onChanged: (bool? value) {
          setState(() {
            isCheck = value!;
          });
        });
  }
}
