import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/mini_widgets.dart';
import 'package:golobe/utils/spaceController/spaces_controller.dart';

class PlayMusicArea extends StatefulWidget {
  final SongEmitCubit triggerSongCb;
  final AnimationController animationController;

  const PlayMusicArea({
    super.key,
    required this.animationController,
    required this.triggerSongCb,
  });

  @override
  State<PlayMusicArea> createState() => PlayMusicAreaState();
}

class PlayMusicAreaState extends State<PlayMusicArea> {
  ValueNotifier<Duration> finishTime = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> currentTime = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    widget.triggerSongCb.initStream(
        animationController: widget.animationController,
        finishTime: finishTime,
        currentTime: currentTime);
  }

  @override
  void dispose() {
    widget.triggerSongCb.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.triggerSongCb,
        builder: (context, state) {
          if (state is SongEmitsucc) {
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
                            RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0)
                                  .animate(widget.animationController),
                              child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: RoundImage(
                                      state.remainSong.image!['url'])),
                            ),
                            HorizontalSpace(value: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.remainSong.author}',
                                  style: const TextStyle(
                                    color: Colorscontroller.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                VerticalSpace(value: 10),
                                Text(
                                  '${state.remainSong.title}',
                                  style: const TextStyle(
                                      color: Colorscontroller.grey,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                        playingController(
                            animation: widget.animationController,
                            remainSong: state.remainSong,
                            audioCubit: widget.triggerSongCb,
                            songUrl: state.remainSong.song!['url'])
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
                                widget.triggerSongCb.onChangeSlider(
                                  value: value,
                                );
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
