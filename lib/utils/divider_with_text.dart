import 'package:flutter/material.dart';

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
