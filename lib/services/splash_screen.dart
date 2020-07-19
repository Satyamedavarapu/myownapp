import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/screens/auth_screens/login_trial.dart';
import 'package:screenwriting/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    print('Check user called');
    checkUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget loader() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<bool> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var email = preferences.getString('EMAIL') ?? null;
    var password = preferences.getString('PASSWORD') ?? null;

    try {
      if (email != null && password != null) {
        isLoading = true;
        final result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("Splash Screen result: " + result.toString());
        if (result.user.uid != null) {
          isLoading = true;
          setState(() {
            return userHome(result.user);
          });
          isLoading = false;
        }
      } else
        setState(() {
          return login();
        });
    } catch (exception) {
      print('try catch error in check user' + exception.toString());
    }

    return null;
  }

  void userHome(FirebaseUser user) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(user)));
  }

  void login() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginTrial()));
  }
}
