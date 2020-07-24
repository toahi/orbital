import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_event.dart';
import 'package:butterfly/ui/pages/matches_page.dart';
import 'package:butterfly/ui/pages/messages.dart';
import 'package:butterfly/ui/pages/profile_page.dart';
import 'package:butterfly/ui/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatelessWidget {
  final userId;
  final userRepository;

  const Home({this.userId, this.userRepository});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ProfilePage(
        userRepository: userRepository,
        userId: userId,
      ),
      Search(
        userId: userId,
      ),
      Matches(
        userId: userId,
      ),
      Messages(
        userId: userId,
      ),
    ];

    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.cyan[200],
      ),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Chill",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TabBar(
                      tabs: <Widget>[
                        Tab(icon: Icon(Icons.settings)),
                        Tab(icon: Icon(Icons.search)),
                        Tab(icon: Icon(Icons.people)),
                        Tab(icon: Icon(Icons.message)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        ),
      ),
    );
  }
}