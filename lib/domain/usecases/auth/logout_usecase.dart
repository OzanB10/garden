import '../../repositories/auth_repository.dart';

class LogoutUsecase {
  const LogoutUsecase({required this.authRepository});

  final AuthRepository authRepository;

  Future<void> execute() async {
    await authRepository.logout();
  }
} 