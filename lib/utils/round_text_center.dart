import 'package:flutter/material.dart';
import 'package:golobe/utils/mini_widgets.dart';

Widget roundTextCenter({required String imgUrl, required String songTitle}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Column(
      children: [
        RoundImage(imgUrl),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 100,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                songTitle,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
