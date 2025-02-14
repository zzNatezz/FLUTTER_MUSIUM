import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/history/songs_cubit.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';

import 'package:golobe/utils/colorsController/colors_controller.dart';
import 'package:golobe/utils/round_text_center.dart';

class FetchedList extends StatefulWidget {
  final SongEmitCubit triggerSongCb;
  final String songTitle;
  final SongCubit songCubit;
  final AnimationController animationController;
  final String domain;
  //
  const FetchedList(
      {super.key,
      required this.animationController,
      required this.songTitle,
      required this.triggerSongCb,
      required this.songCubit,
      required this.domain});

  @override
  State<FetchedList> createState() => _FetchedListState();
}

class _FetchedListState extends State<FetchedList> {
  Future<List<SongEntity>> _convert() async {
    final listSong = await widget.songCubit.fetchSong(widget.domain);
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
          height: 250,
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
                                      index: index,
                                      TriggedSong: snapshot.data[index],
                                      songUrl:
                                          snapshot.data[index].song['url']);
                                  //handle animation playMusicAreaKey
                                  isPlaying
                                      ? widget.animationController.stop()
                                      : widget.animationController.repeat();
                                },
                                child: roundTextCenter(
                                    view: snapshot.data[index].view,
                                    author: snapshot.data[index].author,
                                    index: index,
                                    cubitBuilder: widget.triggerSongCb,
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
