
import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_state.dart';
import 'package:butterfly/bloc/bloc.profile/profile_bloc.dart';
import 'package:butterfly/bloc/bloc.profile/profile_state.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:butterfly/ui/pages/home_page.dart';
import 'package:butterfly/ui/pages/login_page.dart';
import 'package:butterfly/ui/pages/messages.dart';
import 'package:butterfly/ui/pages/profile_page.dart';
import 'package:butterfly/ui/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;


     MyApp ({@required UserRepository userRepository})
        : assert(userRepository != null),
    _userRepository = userRepository;



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UninitialisedState) {
            return Splash();
          }
          if (state is AuthenticatedState) {
            return Home(
              userId: state.userID,
              userRepository: _userRepository,
            );
          }
          if (state is AuthenticatedBlankState) {
            return ProfilePage(
              userRepository: _userRepository,
              userId: state.userID,
            );
          }
          if (state is UnAuthenticatedState) {
            return Login(
              userRepository: _userRepository,
            );
          } else
            return Container();
        },
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        create: (context) => _authenticationBloc,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Butterfly',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: BlocBuilder(
              bloc: _authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state is UninitialisedState) {
                  return Splash();
                }
                if (state is AuthenticatedState) {
                  return SwipeFeedPage();
                }
                if (state is AuthenticatedBlankState){
                  return ProfilePage();
                }
                if (state is UnAuthenticatedState){
                  return Login(
                    userRepository: _userRepository,
                  );
                }
                return Container();
              },
            ),
            routes: {
              '/home': (context) => SwipeFeedPage(),
              '/profile': (context) => ProfilePage(),
              '/settings': (context) => SettingsPage(),
              '/message': (context) => Messages(),
            }
        )

    );
  }

   */
}
