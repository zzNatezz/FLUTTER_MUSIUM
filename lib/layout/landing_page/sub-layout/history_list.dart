import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/fetch_data/history/history_cubit.dart';
import 'package:golobe/utils/round_text_center.dart';
import 'package:just_audio/just_audio.dart';

class HistoryList extends StatefulWidget {
  final String? userId;
  const HistoryList({super.key, this.userId = ""});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final player = AudioPlayer();
  void handlePlayer(String songUrl) {
    player.setUrl(songUrl);
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  Future<List<SongEntity>> _convert() async {
    final HistoryCubit historyCubit = HistoryCubit();
    final listSong = await historyCubit.listenedSong(widget.userId as String);
    return listSong;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 500,
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
                          return Column(
                            children: [
                              roundTextCenter(
                                  imgUrl: snapshot.data[index].image['url'],
                                  songTitle: snapshot.data[index].title),
                              ElevatedButton(
                                  onPressed: () {
                                    handlePlayer(
                                        snapshot.data[index].song['url']);
                                  },
                                  child: const Text('play'))
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
      ),
    );
  }
}
