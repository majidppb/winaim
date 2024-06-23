import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/presentation/auth/login.dart';
import 'package:winaim/presentation/auth/register.dart';
import 'package:winaim/presentation/dashborad/dashboard.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: LoginScreen.path,
  routes: [
    GoRoute(
      path: LoginScreen.path,
      pageBuilder: (context, state) => _getPage(state, const LoginScreen()),
    ),
    GoRoute(
      path: RegisterScreen.path,
      pageBuilder: (context, state) => _getPage(state, const RegisterScreen()),
    ),
    GoRoute(
      path: DashboardScreen.path,
      pageBuilder: (context, state) => _getPage(state, const DashboardScreen()),
    ),
  ],
);

MaterialPage _getPage(GoRouterState state, Widget child) => MaterialPage(
      key: state.pageKey,
      child: child,
    );
