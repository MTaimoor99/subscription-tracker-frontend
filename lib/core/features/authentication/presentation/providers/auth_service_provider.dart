import 'package:riverpod/riverpod.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/domain/services/auth_service.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/providers/auth_repository_provider.dart';

final authServiceProvider = Provider<AuthService>((ref){
  final authRepository = ref.read(authRepositoryProvider);
  return AuthService(authRepository);
});