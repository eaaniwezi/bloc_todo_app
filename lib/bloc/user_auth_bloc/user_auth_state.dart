import 'package:equatable/equatable.dart';

abstract class UserAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserUninitialized extends UserAuthState {}

class UserAuthenticated extends UserAuthState {}

class UserUnauthenticated extends UserAuthState {}

class UserLoading extends UserAuthState {}
