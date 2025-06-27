part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();

  @override
  List<Object> get props => [];
}

class AuthLoggedIn extends AuthEvent {
  final String userName;
  final String passWord;

  const AuthLoggedIn(this.userName, this.passWord);

  @override
  List<Object> get props => [userName, passWord];
}

class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();

  @override
  List<Object> get props => [];
}

class AuthGetUser extends AuthEvent {
  const AuthGetUser();

  @override
  List<Object> get props => [];
}
