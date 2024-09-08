import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/utils/assetsStorage/icon.dart';

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

ClipRRect SquareImage(String url) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(url, fit: BoxFit.fill, width: 70, height: 70));
}

//
dynamic jwtdecode(dynamic data) {
  final jsonEndcoded = jsonEncode(data);
  final jsonDecodedd = jsonDecode(jsonEndcoded);
  final decoded = JWT.decode(jsonDecodedd);
  return decoded;
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final secs = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, secs].join(':');
}

CircleAvatar playingController(
    {required ValueNotifier<bool> isPlaying,
    required Future<void> Function(String songUrl) callBack,
    required String songUrl}) {
  return CircleAvatar(
    radius: 20,
    child: SizedBox(
      height: 30,
      width: 30,
      child: IconButton(
        onPressed: () {
          callBack(songUrl);
        },
        icon: ValueListenableBuilder(
            valueListenable: isPlaying,
            builder: (_, isPlayvalue, __) {
              return SvgPicture.asset(
                  isPlayvalue ? IconsPath.play : IconsPath.pause);
            }),
      ),
    ),
  );
}
