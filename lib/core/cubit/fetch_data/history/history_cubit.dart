import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:golobe/core/cubit/fetch_data/history/history_state.dart';
import 'package:golobe/core/repo/repo_history_list/history_list_repo.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryStart());
  final HistoryListRepo _historyListRepo = HistoryListRepo();
  // Future<void> histroyList(){ try() }
}
