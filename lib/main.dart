import 'package:equifax_poc/core/constants/strings.dart';
import 'package:equifax_poc/core/router/app_router.dart';
import 'package:equifax_poc/core/theme/app_theme.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_controller.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );

  // Resolves AuthController.build(), which reads the saved
  // session id and looks up the matching user before the
  // app ever paints a frame.
  final authState = await container.read(authControllerProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(isLoggedIn: authState.isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.build(
        initialLocation: isLoggedIn ? '/dashboard' : '/login',
      ),
    );
  }
}