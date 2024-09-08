import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
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
  final AudioPlayer player = AudioPlayer();
  ValueNotifier<bool> isPlaying = ValueNotifier(true);
  ValueNotifier<Duration> finishTime = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> currentTime = ValueNotifier(Duration.zero);
  // Duration finishTime = Duration.zero;
  // Duration currentTime = Duration.zero;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  PlayerState? _playerState;

  ///handlePlayer đang bị bug

  Future<void> handlePlayer(String songUrl) async {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value == true) {
      player.pause();
    } else {
      await player.play(UrlSource(songUrl));
    }
  }

  @override
  void initState() {
    super.initState();
    _durationSubscription = player.onDurationChanged.listen((duration) {
      finishTime.value = duration;
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => currentTime.value = p,
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      _playerState = PlayerState.stopped;
      currentTime.value = Duration.zero;
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    player.dispose();
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
                            isPlaying: isPlaying,
                            callBack: handlePlayer,
                            songUrl: state.TriggedSong.song!['url'])
                      ],
                    ),
                    Slider(
                        min: 0,
                        max: finishTime.value.inSeconds.toDouble(),
                        value: currentTime.value.inSeconds.toDouble(),
                        onChanged: (value) {}),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: currentTime,
                              builder: (_, currentTimeValue, __) {
                                return Text(formatTime(currentTimeValue));
                              }),
                          ValueListenableBuilder(
                              valueListenable: finishTime,
                              builder: (_, finishtimeValue, __) {
                                return Text(formatTime(finishtimeValue));
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Text('');
        });
  }
}
