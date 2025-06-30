import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => const AuthRemoteDatasourceImpl(),
  );
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: getIt(),
      localDatasource: getIt(),
    ),
  );

  // Use cases
  getIt.registerFactory(() => LoginUsecase(authRepository: getIt()));
  getIt.registerFactory(() => RegisterUsecase(authRepository: getIt()));
  getIt.registerFactory(() => LogoutUsecase(authRepository: getIt()));
} 