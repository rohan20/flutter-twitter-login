import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "defaultmessage";

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

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '94dfxel253BwSWHP8i3of2Fr8',
    consumerSecret: '9H6PAAnF3P2YjK1WqQyZfW2W7kqkdOXGK4RgWpD0RT55t72Ygk',
  );

  void _login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        newMessage = 'Logged in! username: ${result.session.username}';
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
        break;
    }

    setState(() {
      message = newMessage;
    });
  }

  void _logout() async {
    await twitterLogin.logOut();

    setState(() {
      message = 'Logged out.';
    });
  }
}
