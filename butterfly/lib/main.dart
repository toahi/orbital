import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_event.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_state.dart';
import 'package:butterfly/ui/MyApp.dart';
import 'package:butterfly/ui/pages/login_page.dart';
import 'package:butterfly/ui/pages/messages.dart';
import 'package:butterfly/ui/pages/profile_page.dart';
import 'package:butterfly/ui/pages/signup_page.dart';
import 'package:butterfly/ui/pages/splash.dart';
import 'package:butterfly/bloc/blocDelegate.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/pages/swipe_feed_page.dart';
import 'ui/pages/profile_page_old.dart';
import 'ui/pages/settings_page.dart';
import 'ui/pages/messages_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();

  BlocSupervisor.delegate= SimpleBlocDelegate();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: MyApp(userRepository: _userRepository)));

}
