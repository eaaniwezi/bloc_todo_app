part of 'user_login_bloc.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginFailure extends UserLoginState {
  final String error;

  const UserLoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
