import 'package:flutter/material.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';

class IntroPage extends StatelessWidget {
  static const String IntroPageRoute = 'intro';
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hello, Appbar here')),
        body: ElevatedButton(
          child: const Text('click me'),
          onPressed: () {
            AuthCubit().Logout(context: context);
          },
        ));
  }
}
