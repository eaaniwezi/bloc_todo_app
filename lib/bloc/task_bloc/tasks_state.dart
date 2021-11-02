part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class  TasksInitial extends  TasksState {}

class  TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final  task;
  const TasksLoaded({@required this.task});
  @override
  List<Object> get props => [task];
}



class  TasksFailure extends TasksState {
  final String error;

  const TasksFailure({@required this.error});

  @override
  List<Object> get props => [error];

}
