import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/colorsController/colors_controller.dart';

class PlayMusicArea extends StatefulWidget {
  final SongEmitCubit triggerSongCb;
  const PlayMusicArea({super.key, required this.triggerSongCb});

  @override
  State<PlayMusicArea> createState() => _PlayMusicAreaState();
}

class _PlayMusicAreaState extends State<PlayMusicArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.triggerSongCb,
        builder: (context, state) {
          if (state is SongEmitTrigger) {
            print('state ne ==> $state');
            return Container(
              decoration: BoxDecoration(
                  color: Colorscontroller.grey2,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10), bottom: Radius.circular(10))),
              padding: const EdgeInsets.all(20),
              child: Text('${state.TriggedSong.author}'),
            );
          }
          return const Text('');
        });
  }
}
