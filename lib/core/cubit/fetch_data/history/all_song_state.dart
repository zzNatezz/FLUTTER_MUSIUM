import 'package:equatable/equatable.dart';

sealed class SongState extends Equatable {
  const SongState();
  @override
  List<Object> get props => [];
}

class SongListenedStart extends SongState {}

class SongListenedProcessing extends SongState {}

class SongListenedCompleted extends SongState {}

class SongListenedError extends SongState {}
