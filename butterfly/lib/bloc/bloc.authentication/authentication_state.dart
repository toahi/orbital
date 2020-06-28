import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];

}

class UninitialisedState extends AuthenticationState {
}

class AuthenticatedState extends AuthenticationState {

  final String userID;
  AuthenticatedState(this.userID);

  @override
  List<Object> get props => [userID];

  @override
  String toString() => "Authenticated {UserID}";

}

class AuthenticatedBlankState extends AuthenticationState{

  final String userID;
  AuthenticatedBlankState(this.userID);

  @override
  List<Object> get props => [userID];
}

class UnAuthenticatedState extends AuthenticationState{
}