import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl();

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Mock API call - replace with real implementation
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock validation
    if (email == 'test@test.com' && password == '123456') {
      return const UserModel(
        id: '1',
        email: 'test@test.com',
        name: 'Test User',
        avatarUrl: null,
      );
    } else {
      throw Exception('Geçersiz email veya şifre');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // Mock API call - replace with real implementation
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock user creation
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      avatarUrl: null,
    );
  }
} 