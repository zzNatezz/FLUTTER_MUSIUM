import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/mini_widgets.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';
import 'package:just_audio/just_audio.dart';

class PlayMusicArea extends StatefulWidget {
  final SongEmitCubit triggerSongCb;
  const PlayMusicArea({super.key, required this.triggerSongCb});

  @override
  State<PlayMusicArea> createState() => _PlayMusicAreaState();
}

class _PlayMusicAreaState extends State<PlayMusicArea> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration finishTime = Duration.zero;
  Duration currentTime = Duration.zero;

  Future<void> handlePlayer(String songUrl) async {
    isPlaying = !isPlaying;
    await player.setUrl(songUrl);
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
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
                                  color: Colorscontroller.grey, fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                    Slider(
                        min: 0,
                        max: finishTime.inSeconds.toDouble(),
                        value: currentTime.inSeconds.toDouble(),
                        onChanged: (value) {}),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(currentTime)),
                          playingController(
                              isPlaying: isPlaying,
                              playingFactory:
                                  handlePlayer(state.TriggedSong.song!['url'])),
                          Text(formatTime(finishTime))
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
