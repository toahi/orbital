import 'package:flutter/material.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
