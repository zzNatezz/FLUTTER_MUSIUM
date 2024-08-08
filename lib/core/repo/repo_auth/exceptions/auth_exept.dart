import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

String wordSplit(String word) {
  List<String> listWord = word.split(":");
  final String lastWord = listWord[listWord.length - 1];
  return lastWord;
}

class AlerException implements Exception {
  final String mess;
  const AlerException({required this.mess});

  Future<void> AlertAuth({required BuildContext context}) {
    String _mess = wordSplit(mess);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        'Try again',
                        style: TextStyle(color: Colorscontroller.loginButton),
                      ))
                ],
                title: const Text('Error',
                    style: TextStyle(
                        color: Colorscontroller.warning,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                contentPadding: const EdgeInsets.all(20.0),
                content: Text(
                  _mess,
                  style: const TextStyle(fontSize: 16),
                )));
  }
}
