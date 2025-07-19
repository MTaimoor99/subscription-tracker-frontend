import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/domain/services/auth_service.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState>{
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authenticationService;

  AuthNotifier(this._authenticationService): super (AuthState());

  Future<Map<String,dynamic>> register() async{
    final response = await _authenticationService.register(emailController.text,passwordController.text);
    debugPrint('Response that comes back from Spring Boot API:$response');
    return response;
  }
}