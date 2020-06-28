import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;


  AuthenticationBloc({ @required UserRepository userRepository}):assert(userRepository!=null),_userRepository = userRepository;

  @override
  AuthenticationState get initialState => UninitialisedState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      yield* _mapAppStartedToState();
    }else if(event is LoggedIn){
      yield* _mapLoggedInToState();
    }else if (event is LoggedOut){
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState () async* {
    try{
      final isSignedIn = await _userRepository.isSignedIn();
      if(isSignedIn) {
        final uid = await _userRepository.getUser();
        final isFirstTime = await _userRepository.isFirstTime(uid);

        if (!isFirstTime) {
          yield AuthenticatedBlankState(uid);
        } else {
          yield AuthenticatedState(uid);
        }
      }else{
        yield UnAuthenticatedState();
      }
    }catch(_){
      yield UnAuthenticatedState();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final uid = await _userRepository.getUser();
    final isFirstTime = await _userRepository.isFirstTime(uid);

    if(!isFirstTime){
      yield AuthenticatedBlankState(uid);
    }else{
      yield AuthenticatedState(uid);
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async*{
    yield UnAuthenticatedState();
    _userRepository.signOut();
  }
}
