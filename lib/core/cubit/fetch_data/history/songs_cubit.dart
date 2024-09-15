import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/core/consttants/api_path.dart';
import 'package:golobe/core/cubit/fetch_data/history/all_song_state.dart';

import 'package:golobe/core/repo/repo_song_list/song_list_repo.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(SongListenedStart());
  final SongListRepo _songListRepo = SongListRepo();
  //
  Future<List<SongEntity>> listenedSong(String userId) async {
    try {
      emit(SongListenedProcessing());
      final fetchData = await _songListRepo.fetchSong(
          domain: ApiPath.historySongEP, userId: userId);
      if (fetchData == []) throw Exception();
      emit(SongListenedCompleted());
      return fetchData;
    } catch (e) {
      emit(SongListenedError());
      dev.log(e.toString());
      final List<SongEntity> data = [];
      return data;
    }
  }
}
