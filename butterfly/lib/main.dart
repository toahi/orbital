import 'package:flutter/material.dart';
import 'swipe_feed_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tinder cards demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SwipeFeedPage(),
      routes: {
        '/home': (context) => SwipeFeedPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
      }
    );
  }
}
