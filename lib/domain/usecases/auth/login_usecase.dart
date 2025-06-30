import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class LoginUsecase {
  const LoginUsecase({required this.authRepository});

  final AuthRepository authRepository;

  Future<UserEntity> execute({
    required String email,
    required String password,
  }) async {
    return await authRepository.login(
      email: email,
      password: password,
    );
  }
} 