part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class  MainInitial extends  MainState {}

class  MainLoading extends MainState {}

class MainLoaded extends MainState {
  final  task;
  const MainLoaded({@required this.task});
  @override
  List<Object> get props => [task];
}



class  MainFailure extends MainState {
  final String error;

  const MainFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MainFailure { error: $error }';
}
