import 'package:equifax_poc/features/auth/presentation/controllers/auth_provider.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<bool> login(
    String loginId,
    String password,
  ) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final repository = ref.read(authRepositoryProvider);

      final user = await repository.login(
        loginId.trim(),
        password,
      );

      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid login ID or password.',
        );

        return false;
      }

      state = state.copyWith(
        isLoading: false,
        user: user,
        clearError: true,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );

      return false;
    }
  }

  void logout() {
    state = const AuthState();
  }
}