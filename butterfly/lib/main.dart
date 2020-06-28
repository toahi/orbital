import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_event.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_state.dart';
import 'package:butterfly/ui/pages/login_page.dart';
import 'package:butterfly/ui/pages/signup_page.dart';
import 'package:butterfly/ui/pages/splash.dart';
import 'package:butterfly/bloc/blocDelegate.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/ui/pages/message_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/pages/swipe_feed_page.dart';
import 'ui/pages/profile_page.dart';
import 'ui/pages/settings_page.dart';
import 'ui/pages/message_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate= SimpleBlocDelegate();

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState(){
    _authenticationBloc = AuthenticationBloc(userRepository:  _userRepository);

    _authenticationBloc.add(AppStarted());

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Butterfly',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state){
            if (state is UninitialisedState){
              return Splash();
            }else return Login(
              userRepository: _userRepository,
            );
            }
          ),
          routes: {
            '/home': (context) => SwipeFeedPage(),
            '/profile': (context) => ProfilePage(),
            '/settings': (context) => SettingsPage(),
            '/message': (context) => MessagePage(),
          }
      )

    );
  }
}
