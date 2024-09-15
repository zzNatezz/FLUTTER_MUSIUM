import 'package:equatable/equatable.dart';

sealed class SongState extends Equatable {
  const SongState();
  @override
  List<Object> get props => [];
}

class SongStart extends SongState {}

class SongProcessing extends SongState {}

class SongCompleted extends SongState {}

class SongError extends SongState {}
