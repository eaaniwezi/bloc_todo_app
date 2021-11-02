import 'dart:async';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final UserRepository userRepository;

  MainBloc({
    @required this.userRepository
  })  : assert(userRepository != null), super(null);


  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is GetData) {
      try {
        final  task =  await userRepository.fetchTask();
        yield MainLoaded(task:task);

      } catch (error) {
        yield MainFailure(error: error.toString());
      }
    }
  }

}
