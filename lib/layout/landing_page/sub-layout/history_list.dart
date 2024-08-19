import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';

import 'package:golobe/core/cubit/fetch_data/history/history_cubit.dart';

class HistoryList extends StatefulWidget {
  final String? userId;
  const HistoryList({super.key, required this.userId});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late HistoryCubit _historyCubit;
  late Future<List<SongEntity>> songs;

  @override
  void initState() {
    _historyCubit = HistoryCubit();
    super.initState();
    // songs = _historyCubit.listenedSong(widget.userId as String);
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: FutureBuilder<List<SongEntity>>(
    //       future: songs,
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         if (snapshot.hasData) {
    //           return ListView.builder(
    //               itemCount: snapshot.data.lengh,
    //               itemBuilder: (context, index) {
    //                 ListTile(
    //                   title: Text(snapshot.data[index].titlle),
    //                 );
    //                 return null;
    //               });
    //         } else if (snapshot.hasError) {
    //           return Text(snapshot.error.toString());
    //         } else {
    //           return const CircularProgressIndicator();
    //         }
    //       }),
    // );
    return ElevatedButton(
      onPressed: () {
        _historyCubit.listenedSong(widget.userId as String);
      },
      child: const Text('Click me'),
    );
  }
}
