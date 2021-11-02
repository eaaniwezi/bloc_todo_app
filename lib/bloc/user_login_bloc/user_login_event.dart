part of 'user_login_bloc.dart';

abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();
}

class OnUserLoginButtonPressed extends UserLoginEvent {
  final String email;
  final String password;

  const OnUserLoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
