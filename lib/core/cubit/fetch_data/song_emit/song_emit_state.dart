part of 'song_emit_cubit.dart';

sealed class SongEmitState extends Equatable {
  const SongEmitState();

  @override
  List<Object> get props => [];
}

final class SongEmitInitial extends SongEmitState {}

final class SongEmitLoading extends SongEmitState {}

final class SongEmitfinish extends SongEmitState {}

final class SongEmitsucc extends SongEmitState {
  final SongEntity remainSong;
  const SongEmitsucc({required this.remainSong});
}

final class SongEmitError extends SongEmitState {
  final dynamic error;
  const SongEmitError({required this.error});
}
