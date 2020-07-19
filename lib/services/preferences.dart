import 'package:shared_preferences/shared_preferences.dart';

class SavePreferences {
  static const String EMAIL = 'EMAIL';
  static const String PASSWORD = 'PASSWORD';

  static Future<bool> setEmail(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(EMAIL, email);
  }

  static Future<String> getEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(EMAIL) ?? null;
  }

  static Future<bool> setPassword(String password) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(PASSWORD, password);
  }

  static Future<String> getPassword() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PASSWORD);
  }
}
