import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class RegisterUsecase {
  const RegisterUsecase({required this.authRepository});

  final AuthRepository authRepository;

  Future<UserEntity> execute({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authRepository.register(
      email: email,
      password: password,
      name: name,
    );
  }
} 