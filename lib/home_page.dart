import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "default_message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Login"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {},
            ),
            SizedBox(height: 32.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
