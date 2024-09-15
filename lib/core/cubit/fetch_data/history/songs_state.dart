import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';

import 'package:golobe/core/cubit/fetch_data/history/history_state.dart';
import 'package:golobe/core/repo/repo_history_list/history_list_repo.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(SongStart());
  final SongListRepo _songListRepo = SongListRepo();
  //
  Future<List<SongEntity>> listenedSong(String userId) async {
    try {
      emit(SongProcessing());
      final fetchData = await _songListRepo.fetchHistory(userId: userId);
      if (fetchData == []) throw Exception();
      emit(SongCompleted());
      return fetchData;
    } catch (e) {
      emit(SongError());
      dev.log(e.toString());
      final List<SongEntity> data = [];
      return data;
    }
  }
}
