import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.cyan[200],
        title: Text('My Profile', style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0
        )),

          actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings, color: Colors.white, size: 28.0))
    ]
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('res/guy.png'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              )
            ),
            SizedBox(height: 10.0),
            Text(
                'John Tan',
                style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 2.0,
                  fontSize: 18.0,
                )
            ),
            SizedBox(height: 30.0),
            Text(
                'Age',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                '22',
                style: TextStyle(
                    color: Colors.black,
                    //letterSpacing: 2.0,
                    fontSize: 18.0,
                )
            ),
            SizedBox(height: 30.0),
            Text(
                'Gender',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                'Male',
                style: TextStyle(
                    color: Colors.black,
                    //letterSpacing: 2.0,
                    fontSize: 18.0,
                )
            ),
            SizedBox(height: 30.0),
            Text(
                'Bio',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                'Sagittarius, wanderlust, gym is life',
                style: TextStyle(
                    color: Colors.black,
                    //letterSpacing: 2.0,
                    fontSize: 18.0,
                )
            ),
            SizedBox(height: 30.0),
            Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 10.0),
            Text(
                'johntan@email.com',
                style: TextStyle(
                    color: Colors.black,
                    //letterSpacing: 2.0,
                    fontSize: 18.0,
                )
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: (){
                //logout
              }
            )
          ]
        )
      )
    );
  }
}
