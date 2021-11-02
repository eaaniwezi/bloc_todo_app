import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
import 'user_auth.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final UserRepository userRepository;

  UserAuthBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(null);

  @override
  UserAuthState get initialState => UserUninitialized();

  @override
  Stream<UserAuthState> mapEventToState(
    UserAuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield UserAuthenticated();
      } else {
        yield UserUnauthenticated();
      }
    }

    if (event is UserIsLoggedIn) {
      yield UserLoading();
      await userRepository.persistToken(event.token);
      yield UserAuthenticated();
    }

    if (event is UserIsLoggedOut) {
      yield UserLoading();
      await userRepository.deleteToken();
      yield UserUnauthenticated();
    }
  }

  @override
  void onChange(Change<UserAuthState> change) {
    print(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(UserAuthEvent event) {
    print(event);
    super.onEvent(event);
  }
}
