import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';

class LoginTextField extends StatelessWidget {
  final TextStyle hintStyle;

  //
  final String hintText;
  const LoginTextField(
      {super.key,
      required this.hintText,
      this.hintStyle = const TextStyle(color: Colors.red)});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          border: const OutlineInputBorder()),
    );
  }
}

class PasswordFormField extends StatefulWidget {
  final TextStyle hintStyle;
  final String hintText;

  const PasswordFormField(
      {super.key,
      required this.hintText,
      this.hintStyle = const TextStyle(color: Colors.red)});

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isObs = true;
  void obsController() {
    setState(() {
      isObs = !isObs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObs,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        suffixIconConstraints:
            const BoxConstraints(minHeight: 10, maxHeight: 50),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onTap: () {
              obsController();
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                isObs ? IconsPath.eyeClosed : IconsPath.eye,
                height: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
