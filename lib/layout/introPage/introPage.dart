import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hello, Appbar here')),
        body: ElevatedButton(
          child: const Text('click me'),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
          },
        ));
  }
}
