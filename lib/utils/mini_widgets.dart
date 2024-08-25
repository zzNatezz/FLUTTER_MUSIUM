import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Widget DividerWithText(
    {required String text, Color? dividerColor, double fontSize = 14}) {
  return Row(children: [
    Expanded(
        child: Divider(
      color: dividerColor,
    )),
    Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
    Expanded(child: Divider(color: dividerColor))
  ]);
}

//
ClipRRect RoundImage(String url) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: Image.network(url, fit: BoxFit.fill, width: 100, height: 100));
}

//
dynamic jwtdecode(dynamic data) {
  final jsonEndcoded = jsonEncode(data);
  final jsonDecodedd = jsonDecode(jsonEndcoded);
  final decoded = JWT.decode(jsonDecodedd);
  return decoded;
}
