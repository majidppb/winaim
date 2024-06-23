// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:winaim/data/data.dart';
import 'package:winaim/presentation/auth/login.dart';
import 'package:winaim/presentation/dashborad/new_customer.dart';
import 'package:winaim/presentation/dashborad/new_sale.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/auth.dart';
import 'package:winaim/utils/dio.dart';

part 'widgets/home.dart';
part 'widgets/customers.dart';
part 'widgets/sales.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const path = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  void _onFloatingActionButtonPressed() {
    if (_controller.index == 0) {
    } else if (_controller.index == 1) {
      context
          .push<bool>('${DashboardScreen.path}/${NewCustomerScreen.path}')
          .then((value) {
        if (value == true) {
          _getCustomers();
        }
      });
    } else {
      context
          .push<bool>('${DashboardScreen.path}/${NewSaleScreen.path}')
          .then((value) {
        if (value == true) {
          _getSales();
        }
      });
    }
  }

  Future<void> _getCustomers() async {
    try {
      await getCustomers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
  }

  Future<void> _getSales() async {
    try {
      await getSales();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sorry, something went wrong !'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCustomers();
    });

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
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
              child: Text('Home'),
            ),
            Tab(
              icon: Icon(Icons.person),
              child: Text('Customers'),
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              child: Text('Sales'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: TabBarView(
          controller: _controller,
          children: const [
            HomeWidget(),
            CustomersWidget(),
            SalesWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFloatingActionButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
