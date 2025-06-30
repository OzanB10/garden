import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../states/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
  }) : super(const AuthState());

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await loginUsecase.execute(
        email: email,
        password: password,
      );
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await registerUsecase.execute(
        email: email,
        password: password,
        name: name,
      );
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await logoutUsecase.execute();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
} 