import 'package:screenwriting/repository/auth_repo.dart';

class AuthenticationBloc {
  AuthenticationBloc _instance;

  AuthenticationBloc getInstance() {
    if (_instance == null) _instance = AuthenticationBloc();
    return _instance;
  }

  AuthenticationRepo repo = AuthenticationRepo();

  Future<void> createUser(String email, String password) {
    return repo.createUser(email, password);
  }

  Future<void> loginUser(String email, String password) async {
    return repo.loginUser(email, password);
  }
}
