import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';

import 'package:golobe/core/cubit/fetch_data/history/history_state.dart';
import 'package:golobe/core/repo/repo_history_list/history_list_repo.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryStart());
  final HistoryListRepo _historyListRepo = HistoryListRepo();
  //
  Future<List<SongEntity>> listenedSong(String userId) async {
    try {
      emit(HistoryProcessing());
      final fetchData = await _historyListRepo.fetchHistory(userId: userId);
      if (fetchData == []) throw Exception();
      emit(HistoryCompleted());
      return fetchData;
    } catch (e) {
      emit(HistoryError());
      dev.log(e.toString());
      final List<SongEntity> data = [];
      return data;
    }
  }
}
