import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Widget TextSliding(String text) => SizedBox(
      height: 20,
      width: 100,
      child: Marquee(
        text: text,
        style: const TextStyle(fontSize: 14),
        blankSpace: 30,
      ),
    );
