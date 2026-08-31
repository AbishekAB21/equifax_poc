import 'package:equifax_poc/features/auth/domain/entities/user_profile_entity.dart';

class AuthState {
  final bool isLoading;
  final UserProfileEntity? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    bool? isLoading,
    UserProfileEntity? user,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : user ?? this.user,
      errorMessage:
          clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}