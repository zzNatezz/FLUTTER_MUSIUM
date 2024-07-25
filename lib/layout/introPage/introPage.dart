import 'package:flutter/material.dart';
import 'package:http/http.dart' as prefix;
import 'package:dio/dio.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});

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
