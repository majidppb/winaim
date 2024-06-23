import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/domain/entities/customer.dart';
import 'package:winaim/presentation/auth/login.dart';
import 'package:winaim/presentation/auth/register.dart';
import 'package:winaim/presentation/dashborad/dashboard.dart';
import 'package:winaim/presentation/dashborad/new_customer.dart';
import 'package:winaim/presentation/dashborad/new_interaction.dart';
import 'package:winaim/presentation/dashborad/new_sale.dart';
import 'package:winaim/utils/auth.dart';

part 'redirect.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  redirect: _redirect,
  initialLocation: isLoggedin() ? DashboardScreen.path : LoginScreen.path,
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
      routes: [
        GoRoute(
          path: NewCustomerScreen.path,
          pageBuilder: (context, state) => _getPage(
              state, NewCustomerScreen(customer: state.extra as Customer?)),
        ),
        GoRoute(
          path: NewSaleScreen.path,
          pageBuilder: (context, state) =>
              _getPage(state, const NewSaleScreen()),
        ),
        GoRoute(
          path: NewInteractionScreen.path,
          pageBuilder: (context, state) =>
              _getPage(state, const NewInteractionScreen()),
        ),
      ],
    ),
  ],
);

MaterialPage _getPage(GoRouterState state, Widget child) => MaterialPage(
      key: state.pageKey,
      child: child,
    );
