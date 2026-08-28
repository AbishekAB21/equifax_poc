import 'package:equifax_poc/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:equifax_poc/features/auth/data/repository/auth_repository_impl.dart';
import 'package:equifax_poc/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);

  return AuthLocalDataSource(preferences);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final localDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(localDataSource);
});