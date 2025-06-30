import '../../domain/entities/user_entity.dart';

class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final UserEntity? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  bool get isAuthenticated => user != null;
} 