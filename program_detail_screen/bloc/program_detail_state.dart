import 'package:equatable/equatable.dart';
import 'package:gui_db/program_model.dart';

import '../../user_model.dart';

abstract class ProgramDetailState extends Equatable {
  const ProgramDetailState();

  @override
  List<Object> get props => [];
}

class ProgramDetailInitial extends ProgramDetailState {}

class ProgramDetailLoading extends ProgramDetailState {}

class ProgramDetailSuccess extends ProgramDetailState {
  final List<ProgramModel> programs;

  const ProgramDetailSuccess({required this.programs});

  @override
  List<Object> get props => [programs];

  @override
  String toString() => 'ProgramDetailSuccess {programs : $programs }';
}

class ProgramDetailFailure extends ProgramDetailState {
  final ProgramDetailError error;

  const ProgramDetailFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProgramDetailFailure { error: $error }';
}

enum ProgramDetailError {
  fetching,
  empty,
}
