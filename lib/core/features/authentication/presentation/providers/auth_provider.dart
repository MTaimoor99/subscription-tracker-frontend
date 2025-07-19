import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/providers/auth_service_provider.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/state_notifiers/auth_notifier.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/states/auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref){
  final authenticationService = ref.read(authServiceProvider);
  return AuthNotifier(authenticationService);
});