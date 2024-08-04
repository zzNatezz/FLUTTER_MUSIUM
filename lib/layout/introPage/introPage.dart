import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroPage extends StatelessWidget {
  static const String IntroPageRoute = '/intro';
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hello, Appbar here')),
        body: ElevatedButton(
          child: const Text('click me'),
          onPressed: () {
            context.pushReplacement('/');
          },
        ));
  }
}
