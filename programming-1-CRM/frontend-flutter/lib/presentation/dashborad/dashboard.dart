// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/presentation/auth/login.dart';
import 'package:winaim/utils/dio_provider.dart';

class DashboardScreen extends StatefulWidget {
  static const path = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () async {
              await logout();
              context.go(LoginScreen.path);
            },
            child: const Text('Log out'),
          )
        ],
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.symmetric(horizontal: 50),
        child: ListView(),
      ),
    );
  }
}
