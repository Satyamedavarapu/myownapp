import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/welcome_user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Material(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login Page'),
            TextFormField(
              onChanged: (val) {
                email = val;
              },
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val.isEmpty == true) {
                  return 'Email cannot be empty';
                } else
                  return null;
              },
            ),
            TextFormField(
              onChanged: (val) {
                password = val;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (val) {
                if (val.isEmpty == true) {
                  return 'Email cannot be empty';
                } else
                  return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: InkWell(
                onTap: login,
                child: Container(
                  height: 56.0,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15.0),
                      gradient: LinearGradient(
                          colors: [Colors.lightGreen[300], Colors.green[300]])),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> login() async {
    var formState = _formKey.currentState;

    if (formState.validate() == true) {
      formState.save();

      print('Form Valid');
      print(email);
      print(password);
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(authResult.user);
      print(authResult.user.displayName);
      print(authResult.user.uid);
      if (authResult.user.uid != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Welcome(authResult.user),
            ));
      } else
        return null;
    } else
      return null;
  }
}
