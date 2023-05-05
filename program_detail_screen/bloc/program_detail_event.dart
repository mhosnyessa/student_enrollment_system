import 'package:equatable/equatable.dart';

import '../../program_model.dart';

abstract class ProgramDetailEvent extends Equatable {
  const ProgramDetailEvent();

  @override
  List<Object> get props => [];
}

class ProgramDetailRequested extends ProgramDetailEvent {

  const ProgramDetailRequested();

}
