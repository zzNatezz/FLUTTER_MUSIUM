import 'package:flutter/material.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class RegisterPage extends StatelessWidget {
  static const String registerPageRoute = '/register';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(color: Colorscontroller.loginButton, fontSize: 25),
        ),
      ),
      body: const Text('Hello'),
    );
  }
}
