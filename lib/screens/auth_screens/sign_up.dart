import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenwriting/screens/auth_screens/login_trial.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  var email = '';
  var password = '';
  var errorMessage;

  bool validate() {
    if (signUpForm.currentState.validate() == true) {
      signUpForm.currentState.save();
      return true;
    } else
      return false;
  }

  Widget loader() {
    if (isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else
      return null;
  }

  Widget showAlert() {
    if (errorMessage != null) {
      return Container(
        color: Colors.lightBlue,
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 4.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                errorMessage,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    errorMessage = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: signUpForm,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: showAlert(),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black, fontSize: 24.0),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Display Name'),
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).nextFocus(),
                    validator: (val) {
                      if (val.isEmpty == true) {
                        return 'This field cannot be empty';
                      } else if (val.length < 2) {
                        return 'Display name should contain more than 2 characters';
                      } else if (val.length > 30) {
                        return 'Display name should not exceed 30 characters';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).nextFocus(),
                    onChanged: (val) {
                      email = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field should not be empty';
                      } else if (!val.contains('@')) {
                        return 'Email format is not correct';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(hintText: 'Phone Number'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (val.length != 10) {
                        return 'Mobile number must contain 10 Number';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      password = val;
                    },
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (val.length < 8) {
                        return 'Password should be minimum 8 letters';
                      } else if (val.length > 30) {
                        return 'Password should not exceed 30 letters';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'Both passwords must be the same';
                      } else
                        return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      onPressed: signUp,
                      child: Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (validate() == true) {
      isLoading = true;
      print('Credentials sending ' + email + '' + password);

      try {
        final AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (result.user != null) {
          isLoading = true;
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginTrial()),
              (route) => false);
          isLoading = false;
        }
        isLoading = false;
      } catch (e) {
        setState(() {
          errorMessage = e.message;
        });
      }
    }
  }
}
