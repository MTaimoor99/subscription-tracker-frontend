import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  
  Future<Map<String,dynamic>> register(String email, String password) async {
    return {};
  }
}