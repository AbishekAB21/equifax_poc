import 'package:equifax_poc/features/auth/presentation/controllers/auth_provider.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final repository = ref.read(authRepositoryProvider);

    final user = await repository.restoreSession();

    return AuthState(user: user);
  }

  Future<bool> login(
    String loginId,
    String password,
  ) async {
    state = AsyncData(
      (state.value ?? const AuthState()).copyWith(
        isLoading: true,
        clearError: true,
      ),
    );

    try {
      final repository = ref.read(authRepositoryProvider);

      final user = await repository.login(
        loginId.trim(),
        password,
      );

      if (user == null) {
        state = AsyncData(
          (state.value ?? const AuthState()).copyWith(
            isLoading: false,
            errorMessage: 'Invalid login ID or password.',
          ),
        );

        return false;
      }

      await repository.saveSession(user.id);

      state = AsyncData(AuthState(user: user));

      return true;
    } catch (e) {
      state = AsyncData(
        (state.value ?? const AuthState()).copyWith(
          isLoading: false,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );

      return false;
    }
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);

    await repository.clearSession();

    state = const AsyncData(AuthState());
  }
}