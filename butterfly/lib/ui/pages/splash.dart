import 'package:flutter/material.dart';


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: Container(
        width: size.width,
        child: Center(
          child: Text(
            "Butterfly",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
