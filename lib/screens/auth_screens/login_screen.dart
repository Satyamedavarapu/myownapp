import 'package:flutter/material.dart';
import 'package:screenwriting/blocs/auth_bloc.dart';
import 'package:screenwriting/utils/util_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthenticationBloc authBloc = AuthenticationBloc().getInstance();

  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isVisible = true;

  final FormState form = formKey.currentState;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      form.save();
      return true;
    } else {
      print('Form is invalid');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Container(
              height: height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: height / 3,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/bookbg.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white),
                      child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Username',
                                      style: nameStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        height: 50.0,
                                        decoration: new BoxDecoration(
                                            color: UtilColors.richBrown,
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        padding: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        child: TextFormField(
                                          style: textFieldStyle,
                                          controller: nameController,
                                          onFieldSubmitted: (val) =>
                                              FocusScope.of(context)
                                                  .nextFocus(),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.redAccent)),
                                          validator: (value) => value.isEmpty
                                              ? 'This field cannot be empty'
                                              : null,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Password',
                                      style: nameStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        height: 50.0,
                                        padding: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        decoration: new BoxDecoration(
                                            color: UtilColors.richBrown,
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: TextFormField(
                                          controller: passwordController,
                                          style: textFieldStyle,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.send,
                                          obscureText: isVisible,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.redAccent),
                                              suffixIcon: IconButton(
                                                color: isVisible
                                                    ? UtilColors.richBlue
                                                    : UtilColors.richGold,
                                                icon: Icon(isVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () {
                                                  setState(() {
                                                    isVisible = !isVisible;
                                                  });
                                                },
                                              )),
                                          validator: (val) {
                                            if (val.isEmpty == true) {
                                              return 'This field cannot be empty';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 64.0, right: 64.0, top: 16.0),
                    child: InkWell(
                      onTap: () async {
                        if (validateAndSave() == true) {
                          var email = nameController.text.trim();
                          var password = passwordController.text.trim();
                          final loginResponse =
                              await authBloc.loginUser(email, password);
                        }
                      },

                      child: Container(
                        height: 48.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: UtilColors.richBrown,
                        ),
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 32.0),
                    child: InkWell(
                      onTap: () {
                        print('Sign Up Clicked');
                      },
                      child: Text(
                        'Don\'t have an account? Sign up',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  TextStyle textFieldStyle = new TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.normal);
  TextStyle nameStyle = new TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal);
}
