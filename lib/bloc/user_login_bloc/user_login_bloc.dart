import 'dart:async';
import 'dart:io';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserRepository userRepository;
  final UserAuthBloc userAuthBloc;

  UserLoginBloc({
    @required this.userRepository,
    @required this.userAuthBloc,
  })  : assert(userRepository != null),
        assert(userAuthBloc != null),
        super(null);

  @override
  Stream<UserLoginState> mapEventToState(UserLoginEvent event) async* {
    if (event is OnUserLoginButtonPressed) {
      yield UserLoginLoading();

      try {
        final token = await userRepository.login(
          event.email,
          event.password,
        );
        userAuthBloc.add(UserIsLoggedIn(token: token));
        yield UserLoginInitial();
      } catch (e) {
        print(e);
        if (e is HttpException) {
          Fluttertoast.showToast(
              msg: "Couldn't load data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield UserLoginFailure(error: "Couldn't login");
        } else if (e is! HttpException) {
          print(e);
          Fluttertoast.showToast(
              msg: "Unable to log in with provided credentials.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield UserLoginFailure(error: e.toString());
        }
      }
    }

    @override
    void onChange(Change<UserLoginState> change) {
      print(change.currentState);
      super.onChange(change);
    }

    @override
    void onEvent(UserLoginEvent event) {
      print(event);
      super.onEvent(event);
    }
  }
}
