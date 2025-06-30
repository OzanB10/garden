import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/states/auth_state.dart';
import '../di/injection.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    loginUsecase: getIt(),
    registerUsecase: getIt(),
    logoutUsecase: getIt(),
  ),
); 