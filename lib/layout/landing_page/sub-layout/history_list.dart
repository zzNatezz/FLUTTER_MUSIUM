import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/history/history_cubit.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/utils/round_text_center.dart';

class HistoryList extends StatefulWidget {
  final String? userId;
  final SongEmitCubit triggerSongCb;
  const HistoryList({super.key, this.userId = "", required this.triggerSongCb});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late HistoryCubit historyCubit;

  Future<List<SongEntity>> _convert() async {
    final listSong = await historyCubit.listenedSong(widget.userId as String);
    return listSong;
  }

  @override
  void initState() {
    super.initState();
    historyCubit = HistoryCubit();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          width: MediaQuery.sizeOf(context).width,
          child: Center(
            child: FutureBuilder<List<SongEntity>>(
                future: _convert(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              widget.triggerSongCb.triggerSong(
                                  TriggedSong: snapshot.data[index],
                                  songUrl: snapshot.data[index].song['url']);
                            },
                            child: roundTextCenter(
                                imgUrl: snapshot.data[index].image['url'],
                                songTitle: snapshot.data[index].title),
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
      ),
    );
  }
}
