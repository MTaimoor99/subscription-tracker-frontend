import 'package:subscription_tracker_frontend/core/features/authentication/domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<Map<String,dynamic>> register(String email, String password) async{
    final response = await _authRepository.register(email, password);
    return response;
  }
}