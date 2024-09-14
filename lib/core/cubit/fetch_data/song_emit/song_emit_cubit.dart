import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:golobe/EntityStorage/entity_storage.dart';

part 'song_emit_state.dart';

class SongEmitCubit extends Cubit<SongEmitState> {
  final AudioPlayer player = AudioPlayer();
  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;
  PlayerState? playerState;
  bool isPlaying = false;
  SongEmitCubit() : super(SongEmitInitial());

  Future<void> triggerSong(
      {required SongEntity TriggedSong, required String songUrl}) async {
    try {
      if (TriggedSong.error == true) throw Error();
      emit(SongEmitLoading());
      isPlaying = !isPlaying;
      emit(SongEmitsucc(remainSong: TriggedSong));
      if (isPlaying == true) {
        player.pause();
      } else {
        await player.play(UrlSource(songUrl));
      }
    } catch (e) {
      emit(SongEmitError(error: e));
    }
  }

  //function
  Future<void> handlePlayer(
      {required String songUrl, required SongEntity remainSong}) async {
    emit(SongEmitLoading());
    isPlaying = !isPlaying;
    if (isPlaying == true) {
      player.pause();
    } else {
      await player.play(UrlSource(songUrl));
    }
    emit(SongEmitsucc(remainSong: remainSong));
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
