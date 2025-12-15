
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//? Provider Dio
final dioProvider = Provider<Dio>((ref) {

  Dio dioResponse =  Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  return dioResponse;
});


