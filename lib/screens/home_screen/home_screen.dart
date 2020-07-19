import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/screens/auth_screens/login_trial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Welcome ${widget.user.displayName ?? widget.user.email}'),
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: RaisedButton(
              child: Text('Log out'),
              onPressed: logOut,
            ),
          )
        ],
      ),
    );
  }

  Future<void> logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('EMAIL');
    preferences.remove('PASSWORD');

    await FirebaseAuth.instance.signOut();
    setState(() {
      return pushLogin();
    });
  }

  void pushLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginTrial()),
        (Route<dynamic> route) => false);
  }
}
