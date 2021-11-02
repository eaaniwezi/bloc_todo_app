import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:bloc_todo_app/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
import 'login_body.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  LoginScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Kanban",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: BlocProvider(
        create: (context) {
          return UserLoginBloc(
            userAuthBloc: BlocProvider.of<UserAuthBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginBody(
          userRepository: userRepository,
        ),
      ),
    );
  }
}
