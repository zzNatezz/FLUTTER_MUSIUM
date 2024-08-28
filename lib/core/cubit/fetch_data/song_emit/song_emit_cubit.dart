import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';

part 'song_emit_state.dart';

class SongEmitCubit extends Cubit<SongEmitState> {
  SongEmitCubit() : super(SongEmitInitial());
  void triggerSong(SongEntity TriggedSong) {
    try {
      if (TriggedSong.error == true) throw Error();
      emit(SongEmitLoading());
      emit(SongEmitTrigger(TriggedSong: TriggedSong));
    } catch (e) {
      emit(SongEmitError(error: e));
    }
  }
}
