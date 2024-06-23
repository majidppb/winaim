// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/presentation/auth/register.dart';
import 'package:winaim/presentation/dashborad/dashboard.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/dio_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _username = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_key.currentState!.validate()) {
      try {
        final response = await dioProvider.post(ApiEndpoints.login,
            // options: Options(headers: {'Authorization': 'Token $getToken()'}),
            data: jsonEncode(
                {'username': _username.text, 'password': _password.text}));

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message'] as String),
            ),
          );

          final token = response.data['token'] as String?;
          if (token != null) {
            saveToken(token);
            context.go(DashboardScreen.path);
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorry, something went wrong !'),
          ),
        );
      }
    }
  }

  String? _validateUsername(String? value) {
    return value == null || value.isEmpty
        ? 'Please enter a valid username'
        : null;
  }

  String? _validatePassword(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 8) {
        return 'Password length shold be 8 characters minimum';
      } else {
        return null;
      }
    } else {
      return 'Please enter a valid password';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _username,
                validator: _validateUsername,
                decoration: const InputDecoration(
                  label: Text('User name'),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _password,
                validator: _validatePassword,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go(RegisterScreen.path),
                    child: const Text('Sign Up'),
                  ),
                  ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
