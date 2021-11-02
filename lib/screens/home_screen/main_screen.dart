
import 'package:bloc_todo_app/bloc/task_bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';

import 'main_page.dart';


class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

    HomeScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) => TasksBloc(userRepository: userRepository),
       child: HomeBody()
    );
  }
}
