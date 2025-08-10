import 'package:dio/dio.dart';
import 'package:subscription_tracker_frontend/app_constants.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  
  Future<Map<String,dynamic>> register(String email, String password,String confirmPassword) async {
    try {
      final response = await _dio.post(
        '$localBackendUrl/auth/register',
        data: {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Return the response data
      return response.data as Map<String, dynamic>;
      
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        // Server responded with an error status code
        throw Exception('Registration failed: ${e.response?.data['message'] ?? e.response?.statusMessage}');
      } else {
        // Network error, timeout, etc.
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error: $e');
    }
  }
}
