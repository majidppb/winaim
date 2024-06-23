import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

bool isLoggedin() {
  return prefs.getString('token') != null;
}

String? getToken() {
  return prefs.getString('token');
}

Future<void> saveToken(String token) async {
  await prefs.setString('token', token);
}

Future<void> logout() async {
  prefs.clear();
}
