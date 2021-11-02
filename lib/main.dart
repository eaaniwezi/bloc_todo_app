import 'package:bloc_todo_app/screens/home_screen/main_screen.dart';
import 'package:bloc_todo_app/screens/login_users/login_screen.dart';
import 'package:flutter/material.dart';
import 'repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_auth_bloc/user_auth_event.dart';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth_state.dart';


void main() {
  final userRepository = UserRepository();
  runApp(
    BlocProvider<UserAuthBloc>(
      create: (context) {
        return UserAuthBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<UserAuthBloc, UserAuthState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            return HomeScreen(userRepository: userRepository);
          }
          if (state is UserUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is UserLoading) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Please wait a while...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Please wait a while...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
