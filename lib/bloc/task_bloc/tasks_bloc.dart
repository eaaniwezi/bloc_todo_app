import 'dart:async';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final UserRepository userRepository;

  TasksBloc({
    @required this.userRepository
  })  : assert(userRepository != null), super(null);


  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is FetchData) {
      try {
        final  task =  await userRepository.fetchTask();
        yield TasksLoaded(task:task);

      } catch (error) {
        yield TasksFailure(error: error.toString());
      }
    }
  }
@override
  void onChange(Change<TasksState> change) {
    print(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(TasksEvent event) {
    print(event);
    super.onEvent(event);
  }
}
