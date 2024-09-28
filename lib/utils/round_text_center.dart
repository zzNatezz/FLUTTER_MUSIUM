import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/animation/animation.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

import 'package:golobe/utils/mini_widgets.dart';

Widget roundTextCenter({
  required String imgUrl,
  required String songTitle,
  required SongEmitCubit cubitBuilder,
  required int index,
  required int view,
  required String author,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Column(
      children: [
        RoundImage(imgUrl),
        BlocBuilder(
            bloc: cubitBuilder,
            builder: (context, state) {
              if (state is SongEmitsucc &&
                  state.index == index &&
                  isPlaying == false) {
                return TextSliding(songTitle); //<-- check lai trong zalo
              }
              return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                      width: 100,
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                style: const TextStyle(
                                    color: Colorscontroller.grey, fontSize: 10),
                                'view: $view',
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Text(
                                style: const TextStyle(
                                    color: Colorscontroller.grey, fontSize: 10),
                                author,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Text(
                                style: const TextStyle(
                                    color: Colorscontroller.black,
                                    fontSize: 14),
                                songTitle,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ))));
            }),
      ],
    ),
  );
}
