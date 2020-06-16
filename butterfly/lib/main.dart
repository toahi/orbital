import 'package:flutter/material.dart';
import 'package:tinder_cards/ui/pages/message_page.dart';
import 'ui/pages/swipe_feed_page.dart';
import 'ui/pages/profile_page.dart';
import 'ui/pages/settings_page.dart';
import 'ui/pages/message_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Butterfly',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SwipeFeedPage(),
      routes: {
        '/home': (context) => SwipeFeedPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/message': (context) => MessagePage(),
      }
    );
  }
}
