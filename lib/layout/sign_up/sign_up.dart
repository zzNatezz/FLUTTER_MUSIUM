import 'package:flutter/material.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static String get routerConfig => 'register';

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
      body: const Column(
        children: [
          Center(
              child:
                  Text('Regist new account', style: TextStyle(fontSize: 30))),
        ],
      ),
    );
  }
}
