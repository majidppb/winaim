part of 'router.dart';

// Allow/Restrict a user from accessing a route, based on user's Login status
String? _redirect(BuildContext context, GoRouterState state) {
  final path = state.fullPath;

  // if (!isLoggedin() &&
  //     (path != RegisterScreen.path || path != LoginScreen.path)) {
  //   return LoginScreen.path;
  // }
  return null;
}
