import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/history/songs_cubit.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';

import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/round_text_center.dart';

class HistoryList extends StatefulWidget {
  final String? userId;
  final SongEmitCubit triggerSongCb;
  final String songTitle;
  final SongCubit songCubit;
  final AnimationController animationController;
  //
  const HistoryList(
      {super.key,
      required this.animationController,
      required this.songTitle,
      this.userId = "",
      required this.triggerSongCb,
      required this.songCubit});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  Future<List<SongEntity>> _convert() async {
    final listSong =
        await widget.songCubit.listenedSong(widget.userId as String);
    return listSong;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.songTitle,
            style: TextStyle(fontSize: 20, color: Colorscontroller.songTitle),
          ),
        ),
        SizedBox(
          height: 180,
          width: MediaQuery.sizeOf(context).width,
          child: Align(
            child: FutureBuilder<List<SongEntity>>(
                future: _convert(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  widget.triggerSongCb.triggerSong(
                                      TriggedSong: snapshot.data[index],
                                      songUrl:
                                          snapshot.data[index].song['url']);
                                  //handle animation playMusicAreaKey
                                  widget.animationController.isAnimating
                                      ? widget.animationController.stop()
                                      : widget.animationController.repeat();
                                },
                                child: roundTextCenter(
                                    imgUrl: snapshot.data[index].image['url'],
                                    songTitle: snapshot.data[index].title),
                              ),
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Text("Login to see your list song");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ],
    );
  }
}
