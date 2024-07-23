import 'package:flutter/material.dart';
import 'package:http/http.dart' as prefix;
import 'package:dio/dio.dart';

class IntroPage extends StatelessWidget {
  var jsonList;

  IntroPage({super.key});

  void getData() async {
    try {
      Response res = await Dio()
          .get('https://protocoderspoint.com/jsondata/superheros.json');
      if (res.statusCode == 200) {
        jsonList = res.data['superheros'] as List;
        print(jsonList);
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hello, Appbar here')),
        body: ElevatedButton(
          child: const Text('click me'),
          onPressed: () {
            // Navigator.popAndPushNamed(context, '/login');
            getData();
          },
        ));
  }
}
