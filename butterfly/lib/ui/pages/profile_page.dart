import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_event.dart';
import 'package:butterfly/bloc/bloc.profile/bloc.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:butterfly/ui/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatelessWidget {
  final _userRepository;
  final userId;

  ProfilePage({@required UserRepository userRepository, String userId})
      : assert(userRepository != null  && userId != null),
        _userRepository = userRepository,
        userId = userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.cyan[100],
        elevation: 0,
          actions: <Widget>[
          IconButton(
              onPressed: (){
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white, size: 28.0))
          ]
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(userRepository: _userRepository),
        child: ProfileForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}