import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  @override
  Future<UserEntity?> getCurrentUser() async {
    final cachedUser = await localDatasource.getCachedUser();
    return cachedUser?.toEntity();
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await remoteDatasource.login(
      email: email,
      password: password,
    );
    await localDatasource.cacheUser(user: userModel);
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final userModel = await remoteDatasource.register(
      email: email,
      password: password,
      name: name,
    );
    await localDatasource.cacheUser(user: userModel);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDatasource.clearUser();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return await localDatasource.isUserCached();
  }
} 