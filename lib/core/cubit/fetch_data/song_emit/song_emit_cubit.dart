import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';
import 'package:golobe/utils/assetsStorage/global_var.dart';
part 'song_emit_state.dart';

class SongEmitCubit extends Cubit<SongEmitState> {
  final AudioPlayer player = AudioPlayer();
  //

  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;
  PlayerState? playerState;

  SongEmitCubit() : super(SongEmitInitial());
  List<SongEntity> prevSong = [];

  Future<void> triggerSong(
      {required SongEntity TriggedSong, required String songUrl}) async {
    try {
      if (TriggedSong.error == true) throw Error();
      prevSong.add(TriggedSong);
      if (prevSong.length > 2) {
        prevSong.removeAt(0);
      }
      if (prevSong[0].id == prevSong[1].id) {
        emit(SongEmitLoading());
        isPlaying = !isPlaying;
        emit(SongEmitsucc(remainSong: TriggedSong));

        if (isPlaying == true) {
          player.pause();
        } else {
          await player.play(UrlSource(songUrl)); //Thang này đang bị bug
        }
      } else {
        emit(SongEmitLoading());
        isPlaying = true;
        player.stop();
        emit(SongEmitsucc(remainSong: TriggedSong));
      }
    } catch (e) {
      emit(SongEmitError(error: e));
    }
  }

  //function
  Future<void> handlePlayer({
    required String songUrl,
    required SongEntity remainSong,
  }) async {
    emit(SongEmitLoading());
    isPlaying = !isPlaying;
    emit(SongEmitsucc(remainSong: remainSong));
    if (isPlaying == true) {
      player.pause();
    } else {
      await player.play(UrlSource(songUrl));
    }
  }

  void initStream(
      {required ValueNotifier<Duration> finishTime,
      required ValueNotifier<Duration> currentTime}) {
    durationSubscription = player.onDurationChanged.listen((duration) {
      finishTime.value = duration;
    });

    positionSubscription = player.onPositionChanged.listen(
      (p) => currentTime.value = p,
    );

    playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      playerState = PlayerState.stopped;
      currentTime.value = Duration.zero;
    });
  }

  void dipose() {
    durationSubscription?.cancel();
    positionSubscription?.cancel();
    playerCompleteSubscription?.cancel();
    playerStateChangeSubscription?.cancel();
    player.dispose();
  }

  Future<void> onChangeSlider({required double value}) async {
    final dynamicPosition = Duration(seconds: value.toInt());
    await player.seek(dynamicPosition);
  }
}
