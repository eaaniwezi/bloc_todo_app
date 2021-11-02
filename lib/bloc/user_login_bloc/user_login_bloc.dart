import 'dart:async';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth.dart';
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
        assert(userAuthBloc != null), super(null);

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
      } catch (error) {
        yield UserLoginFailure(error: error.toString());
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
