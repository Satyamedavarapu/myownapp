import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/welcome_user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController, passwordController;
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Email cannot be empty';
                } else
                  return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (val) {
                if (val.isEmpty) {
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
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (formState.validate()) {
      formState.save();

      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (authResult.user != null) {

       Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome(authResult.user),));




      }
    }
  }
}
