import 'package:flutter/material.dart';
import 'package:golobe/core/consttants/api_path.dart';
import 'package:golobe/core/cubit/fetch_data/history/songs_cubit.dart';
import 'package:golobe/core/cubit/fetch_data/song_emit/song_emit_cubit.dart';
import 'package:golobe/layout/landing_page/components/play_music_area.dart';
import 'package:golobe/layout/landing_page/sub-layout/body/widgets/fetched_list.dart';

class BodyLayout extends StatefulWidget {
  const BodyLayout({super.key});

  @override
  State<BodyLayout> createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> with TickerProviderStateMixin {
  late SongEmitCubit _triggerSongCb;
  late SongCubit songCubit;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _triggerSongCb = SongEmitCubit();
    songCubit = SongCubit();

    //
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInCirc);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  FetchedList(
                      domain: ApiPath.trendingSong,
                      animationController: animationController,
                      songTitle: 'Trending',
                      triggerSongCb: _triggerSongCb,
                      songCubit: songCubit),
                ],
              ),
            ),
            PlayMusicArea(
                animationController: animationController,
                triggerSongCb: _triggerSongCb)
          ],
        ),
      ),
    ]);
  }
}
