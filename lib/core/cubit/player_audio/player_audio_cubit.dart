import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'player_audio_state.dart';

class HandlePlayerAudioCubit extends Cubit<PlayerController> {
  //delacre variable
  final AudioPlayer player = AudioPlayer();
  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;
  PlayerState? playerState;
  bool isPlaying = false;

  HandlePlayerAudioCubit() : super(PlayerControllerInitial());

  //function
  Future<void> handlePlayer({required String songUrl}) async {
    emit(PlayerControllerProcessing());
    isPlaying = !isPlaying;
    if (isPlaying == true) {
      player.pause();
    } else {
      await player.play(UrlSource(songUrl));
    }
    emit(PlayerControllerFinish(isPlaying: isPlaying));
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
