import 'package:butterfly/bloc/bloc.login/login_bloc.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:butterfly/ui/widgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;


  Login({ @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome",
          style: TextStyle(fontSize: 36.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan[100],
        elevation: 0,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(
              userRepository: _userRepository,
            ),
        child: LoginForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}


//In this case its not necessary to have a stateful widget because we are
// not using states, The sign up form is done in the form of a stateful widget
// but it isnt necessary