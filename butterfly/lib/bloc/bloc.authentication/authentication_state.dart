import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];

}

class UninitialisedState extends AuthenticationState { //app has not been started
}

class AuthenticatedState extends AuthenticationState { //App has been started and the user is authenticated

  final String userID;
  AuthenticatedState(this.userID);

  @override
  List<Object> get props => [userID];

  @override
  String toString() => "Authenticated {UserID}";

}

class AuthenticatedBlankState extends AuthenticationState{  //App has been started and user is authenticated but user is a first time user and therefore needs to set up account

  final String userID;
  AuthenticatedBlankState(this.userID);

  @override
  List<Object> get props => [userID];
}

class UnAuthenticatedState extends AuthenticationState{ //App has been started and user has not authenticated yet,
}

