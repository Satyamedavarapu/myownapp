import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final FirebaseUser user;

  Welcome(this.user);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('Welcome ${user.email}'),
      ),
    );
  }
}
