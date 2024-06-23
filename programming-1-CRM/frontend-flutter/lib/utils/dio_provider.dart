import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';

final dioProvider = Dio(
  BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
  ),
);

// Token persistance
late final SharedPreferences prefs;

String? getToken() {
  return prefs.getString('token');
}

Future<void> saveToken(String token) async {
  await prefs.setString('token', token);
}

Future<void> logout() async {
  prefs.clear();
}
