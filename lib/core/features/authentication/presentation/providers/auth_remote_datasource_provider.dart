import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/data/datasources/remote/auth_remote_datasource.dart';


final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = Dio();
  return AuthRemoteDataSource(dio);
});