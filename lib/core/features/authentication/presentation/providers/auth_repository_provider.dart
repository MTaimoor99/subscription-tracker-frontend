import 'package:riverpod/riverpod.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/domain/repositories/auth_repository.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/domain/repositories/auth_repository_impl.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/providers/auth_remote_datasource_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});