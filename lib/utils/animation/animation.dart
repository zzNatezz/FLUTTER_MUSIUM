import 'package:flutter/material.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:marquee/marquee.dart';

Widget TextSliding(String text) => Marquee(
      text: text,
      style: const TextStyle(fontSize: 24, color: Colorscontroller.blue),
      blankSpace: 50,
    );
