import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
              onPressed: _login,
            ),
            RaisedButton(
              child: Text("Logout"),
              onPressed: _logout,
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
        _signInWithTwitter(result.session.token, result.session.secret);
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

  void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: token, authTokenSecret: secret);
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        message = 'Successfully signed in with Twitter. ' + user.uid;
      } else {
        message = 'Failed to sign in with Twitter. ';
      }
    });
  }

  void _logout() async {
    await twitterLogin.logOut();

    await _auth.signOut();

    setState(() {
      message = 'Logged out.';
    });
  }
}
