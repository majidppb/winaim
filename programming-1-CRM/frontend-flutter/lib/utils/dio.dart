import 'package:dio/dio.dart';
import 'package:winaim/utils/api_endpoints.dart.dart';

final dioProvider = Dio(
  BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
  ),
);
