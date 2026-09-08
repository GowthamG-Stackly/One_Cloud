import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../pages/about_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/dashboard_page.dart';
import '../providers/user_provider.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String about = '/about';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: login,

    redirect: (context, state) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final loggedIn = userProvider.isLoggedIn;
      final location = state.uri.path;

      final isLoginPage = location == login;

      final isAuthPage = location == register || location == forgotPassword;

      // Logged-in user trying to open Login.
      if (loggedIn && isLoginPage) {
        return dashboard;
      }

      // Logged-out user can access Login,
      // Register and Forgot Password.
      if (!loggedIn && !isLoginPage && !isAuthPage) {
        return login;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: register,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),

      GoRoute(
        path: forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordPage();
        },
      ),

      GoRoute(
        path: dashboard,
        builder: (context, state) {
          return const DashboardPage();
        },
      ),

      GoRoute(
        path: about,
        builder: (context, state) {
          return const AboutPage();
        },
      ),

      GoRoute(
        path: profile,
        builder: (context, state) {
          return const ProfilePage();
        },
      ),
    ],
  );
}
