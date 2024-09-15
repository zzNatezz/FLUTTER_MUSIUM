import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/cubit/auth/auth_musium/auth_cubit.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/layout/landing_page/sub-layout/appbar_title.dart';
import 'package:golobe/layout/landing_page/sub-layout/history_list.dart';
import 'package:golobe/layout/landing_page/components/play_music_area.dart';

//
class LandingPage extends StatelessWidget {
  static const landingPageRoute = '/';
  final LoginEntity? user;
  final AuthCubit authCubit = AuthCubit();
  final SongEmitCubit _triggerSongCb = SongEmitCubit();
  LandingPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade200,
            title: AppbarTitle(user: user)),
        drawer: const Drawer(),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      HistoryList(
                        songTitle: 'Song listended',
                        userId: user?.id,
                        triggerSongCb: _triggerSongCb,
                      )
                    ],
                  ),
                ),
                PlayMusicArea(triggerSongCb: _triggerSongCb)
              ],
            ),
          ),
        ]),
        bottomSheet: const Text('Handle navigate area'));
  }
}
