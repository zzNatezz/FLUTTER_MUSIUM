import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/core/cubit/player_audio/player_audio_cubit.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/mini_widgets.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayMusicArea extends StatefulWidget {
  final SongEmitCubit triggerSongCb;
  const PlayMusicArea({super.key, required this.triggerSongCb});

  @override
  State<PlayMusicArea> createState() => _PlayMusicAreaState();
}

class _PlayMusicAreaState extends State<PlayMusicArea> {
  late HandlePlayerAudioCubit playerCubit;
  ValueNotifier<bool> isPlaying = ValueNotifier(true);
  ValueNotifier<Duration> finishTime = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> currentTime = ValueNotifier(Duration.zero);

  ///handlePlayer đang bị bug

  @override
  void initState() {
    super.initState();
    playerCubit = HandlePlayerAudioCubit()
      ..initStream(finishTime: finishTime, currentTime: currentTime);
  }

  @override
  void dispose() {
    playerCubit.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.triggerSongCb,
        builder: (context, state) {
          if (state is SongEmitTrigger) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colorscontroller.whitText,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20), bottom: Radius.circular(20))),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SquareImage(state.TriggedSong.image!['url']),
                            HorizontalSpace(value: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.TriggedSong.author}',
                                  style: const TextStyle(
                                    color: Colorscontroller.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                VerticalSpace(value: 10),
                                Text(
                                  '${state.TriggedSong.title}',
                                  style: const TextStyle(
                                      color: Colorscontroller.grey,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                        playingController(
                            audioCubit: playerCubit,
                            songUrl: state.TriggedSong.song!['url'])
                      ],
                    ),
                    ValueListenableBuilder(
                        valueListenable: currentTime,
                        builder: (_, currentTimeValue, __) {
                          return Slider(
                              min: 0,
                              max: finishTime.value.inSeconds.toDouble(),
                              value: currentTimeValue.inSeconds.toDouble(),
                              onChanged: (double value) {
                                playerCubit.onChangeSlider(value: value);
                              });
                        }),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: currentTime,
                              builder: (_, currentPlace, __) {
                                return Text(formatTime(currentPlace));
                              }),
                          ValueListenableBuilder(
                              valueListenable: finishTime,
                              builder: (_, finishValue, __) {
                                return Text(formatTime(finishTime.value));
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Text('');
        });
  }
}
