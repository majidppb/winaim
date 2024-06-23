import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:winaim/domain/entities/customer.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';
import 'package:winaim/utils/auth.dart';
import 'package:winaim/utils/dio.dart';

final customers = ValueNotifier<List<Customer>>([]);
final sales = ValueNotifier<List<Customer>>([]);
final interactions = ValueNotifier<List<Customer>>([]);

Future<void> getSales() async {}

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
