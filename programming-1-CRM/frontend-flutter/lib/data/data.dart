import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:winaim/domain/entities/customer.dart';
import 'package:winaim/domain/entities/sale.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/auth.dart';
import 'package:winaim/utils/dio.dart';

// Customer
final customers = ValueNotifier<List<Customer>>([]);

Future<void> getCustomers() async {
  final token = getToken();
  final response = await dioProvider.get(
    ApiEndpoints.customer,
    options: Options(headers: {'Authorization': 'Token $token'}),
  );

  if (response.statusCode == 200) {
    customers.value =
        (response.data as List).map((e) => Customer.fromJson(e)).toList();
  }
}

// Sale
final sales = ValueNotifier<List<Sale>>([]);

Future<void> getSales() async {
  final token = getToken();
  final response = await dioProvider.get(
    ApiEndpoints.sale,
    options: Options(headers: {'Authorization': 'Token $token'}),
  );

  if (response.statusCode == 200) {
    final newSales =
        (response.data as List).map((e) => Sale.fromJson(e)).toList();
    sales.value = newSales;
  }
}
