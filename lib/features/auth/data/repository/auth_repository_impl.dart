import 'package:equifax_poc/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:equifax_poc/features/auth/domain/entities/user_profile_entity.dart';
import 'package:equifax_poc/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<void> register(UserProfileEntity user) async {
    final users = await _localDataSource.getUsers();

    final userExists = users.any(
      (existingUser) =>
          existingUser.loginId == user.loginId ||
          existingUser.email == user.email,
    );

    if (userExists) {
      throw Exception('User already exists');
    }

    await _localDataSource.saveUser(user);
  }

  @override
  Future<UserProfileEntity?> login(
    String loginId,
    String password,
  ) async {
    final users = await _localDataSource.getUsers();

    try {
      return users.firstWhere(
        (user) =>
            (user.loginId == loginId || user.email == loginId) &&
            user.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<UserProfileEntity>> getUsers() {
    return _localDataSource.getUsers();
  }

  @override
  Future<void> saveSession(String userId) {
    return _localDataSource.saveSession(userId);
  }

  @override
  Future<UserProfileEntity?> restoreSession() async {
    final userId = _localDataSource.getSessionUserId();

    if (userId == null) {
      return null;
    }

    final users = await _localDataSource.getUsers();

    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearSession() {
    return _localDataSource.clearSession();
  }
}