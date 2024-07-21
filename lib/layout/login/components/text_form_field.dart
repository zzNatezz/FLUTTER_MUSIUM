import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final bool isObs;
  final TextStyle hintStyle;

  //
  final String hintText;
  const LoginTextField(
      {super.key,
      required this.hintText,
      this.isObs = false,
      this.hintStyle = const TextStyle(color: Colors.red)});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObs,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          border: const OutlineInputBorder()),
    );
  }
}
