import 'package:flutter/material.dart';


class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.cyan[200],
        title: Text('Messages', style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0
        )),
      ),
      backgroundColor: Colors.white,
    );
  }
}
