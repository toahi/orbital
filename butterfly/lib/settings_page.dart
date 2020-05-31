import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.cyan[200],
        title: Text('My Settings', style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0
        )),
      ),
      backgroundColor: Colors.white,
    );
  }
}
