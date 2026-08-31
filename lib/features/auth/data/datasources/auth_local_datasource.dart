import 'dart:convert';

import 'package:equifax_poc/features/auth/domain/entities/user_profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  static const String _usersKey = 'users';
  static const String _sessionKey = 'current_user_id';

  final SharedPreferences _preferences;

  AuthLocalDataSource(this._preferences);

  Future<void> saveUser(UserProfileEntity user) async {
    final users = await getUsers();

    users.add(user);

    final usersJson = users
        .map((user) => user.toJson())
        .toList();

    await _preferences.setString(
      _usersKey,
      jsonEncode(usersJson),
    );
  }

  Future<List<UserProfileEntity>> getUsers() async {
    final usersString = _preferences.getString(_usersKey);

    if (usersString == null || usersString.isEmpty) {
      return [];
    }

    final List<dynamic> usersJson = jsonDecode(usersString);

    return usersJson
        .map(
          (userJson) => UserProfileEntity.fromJson(
            Map<String, dynamic>.from(userJson),
          ),
        )
        .toList();
  }

  Future<void> saveSession(String userId) {
    return _preferences.setString(_sessionKey, userId);
  }

  String? getSessionUserId() {
    return _preferences.getString(_sessionKey);
  }

  Future<void> clearSession() {
    return _preferences.remove(_sessionKey);
  }
}