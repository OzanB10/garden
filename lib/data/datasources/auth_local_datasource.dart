import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class AuthLocalDatasource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser({required UserModel user});
  Future<void> clearUser();
  Future<bool> isUserCached();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  const AuthLocalDatasourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  static const String _userKey = 'CACHED_USER';

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(_userKey);
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> cacheUser({required UserModel user}) async {
    final jsonString = jsonEncode(user.toJson());
    await sharedPreferences.setString(_userKey, jsonString);
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(_userKey);
  }

  @override
  Future<bool> isUserCached() async {
    return sharedPreferences.containsKey(_userKey);
  }
} 