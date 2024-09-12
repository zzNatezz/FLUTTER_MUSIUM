part of 'player_audio_cubit.dart';

sealed class PlayerController extends Equatable {
  const PlayerController();

  @override
  List<Object> get props => [];
}

final class PlayerControllerInitial extends PlayerController {}

final class PlayerControllerProcessing extends PlayerController {}

final class PlayerControllerFinish extends PlayerController {
  final bool isPlaying;
  const PlayerControllerFinish({required this.isPlaying});
}
