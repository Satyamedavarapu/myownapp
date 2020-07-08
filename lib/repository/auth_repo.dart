import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepo {
  AuthenticationRepo _instance;

  AuthenticationRepo getInstance() {
    if (_instance == null) _instance = AuthenticationRepo();
    return _instance;
  }

  AuthCalls authCalls = AuthCalls();

  Future<void> createUser(String email, String password) async {
    return await authCalls.createUser(email, password);
  }

  Future<void> loginUser(String email, String password) async {
    return await authCalls.loginUser(email, password);
  }

}

class AuthCalls {
  Future<void> createUser(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return result.user;
  }

  Future<void> loginUser(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return result.user;
  }
}
