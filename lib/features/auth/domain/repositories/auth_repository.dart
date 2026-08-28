import 'package:equifax_poc/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthRepository {
  Future<void> register(UserProfileEntity user);

  Future<UserProfileEntity?> login(
    String loginId,
    String password,
  );

  Future<List<UserProfileEntity>> getUsers();
}