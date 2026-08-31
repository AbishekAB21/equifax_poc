import 'package:equifax_poc/features/auth/presentation/dashboard_screen.dart';
import 'package:equifax_poc/features/auth/presentation/login_screen.dart';
import 'package:equifax_poc/features/regirstration/presentation/screens/registration_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}