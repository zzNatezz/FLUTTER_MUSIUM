import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';
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
      child: Image.network(url, fit: BoxFit.fill, width: 100, height: 100,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('Error');
      }));
}

ClipRRect SquareImage(String url) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(url, fit: BoxFit.fill, width: 70, height: 70,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('Error');
      }));
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
    {required SongEmitCubit audioCubit,
    required String songUrl,
    required SongEntity remainSong,
    required AnimationController animation}) {
  return CircleAvatar(
    radius: 20,
    child: SizedBox(
      height: 30,
      width: 30,
      child: IconButton(
          onPressed: () {
            audioCubit.handlePlayer(songUrl: songUrl, remainSong: remainSong);
            isPlaying ? animation.stop() : animation.repeat();
          },
          icon: SvgPicture.asset(isPlaying ? IconsPath.pause : IconsPath.play)),
    ),
  );
}
