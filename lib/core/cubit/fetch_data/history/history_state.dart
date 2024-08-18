import 'package:equatable/equatable.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object> get props => [];
}

class HistoryStart extends HistoryState {}

class HistoryProcessing extends HistoryState {}

class HistoryCompleted extends HistoryState {}

class HistoryError extends HistoryState {}
