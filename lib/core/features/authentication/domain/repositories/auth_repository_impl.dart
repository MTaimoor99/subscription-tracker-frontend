import 'package:subscription_tracker_frontend/core/features/authentication/data/datasources/remote/auth_remote_datasource.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource _remoteDataSource;
  
  AuthRepositoryImpl(this._remoteDataSource);

  
  @override
  Future<Map<String,dynamic>> register() async{
    return {};
  }
}