import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends UserAuthEvent {}

class UserIsLoggedIn extends UserAuthEvent {
  final String token;

  const UserIsLoggedIn({@required this.token});

  @override
  List<Object> get props => [token];
}

class UserIsLoggedOut extends UserAuthEvent {}
