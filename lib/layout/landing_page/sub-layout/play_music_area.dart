import 'package:flutter/material.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class PlayMusicArea extends StatefulWidget {
  const PlayMusicArea({super.key});

  @override
  State<PlayMusicArea> createState() => _PlayMusicAreaState();
}

class _PlayMusicAreaState extends State<PlayMusicArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colorscontroller.grey2,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10))),
      padding: const EdgeInsets.all(20),
      child: const Text('Playing music area'),
    );
  }
}
