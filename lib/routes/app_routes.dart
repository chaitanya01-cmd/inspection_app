import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../services/auth_service.dart';

import '../screens/splash_screen.dart';
import '../screens/role_selection_screen.dart';
import '../screens/login_screen.dart';
import '../screens/inspector_dashboard.dart';
import '../screens/municipal_dashboard.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(
      RouteSettings settings,
      AuthService authService,
      ) {
    switch (settings.name) {
    // =========================
    // SPLASH
    // =========================
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(
            authService: authService,
          ),
        );

    // =========================
    // ROLE SELECTION
    // =========================
      case '/role-selection':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RoleSelectionScreen(
            authService: authService,
          ),
        );

    // =========================
    // LOGIN
    // =========================
      case '/login':
        final arguments = settings.arguments;

        // Make sure a role was actually passed.
        if (arguments is! UserRole) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Error: No user role selected.',
                ),
              ),
            ),
          );
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(
            authService: authService,
            role: arguments,
          ),
        );

    // =========================
    // DASHBOARD
    // =========================
      case '/dashboard':
      // User must be logged in.
        if (!authService.isLoggedIn) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Please login first.',
                ),
              ),
            ),
          );
        }

        // Inspector
        if (authService.role == UserRole.inspector) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => InspectorDashboard(
              authService: authService,
            ),
          );
        }

        // Municipal Officer
        if (authService.role == UserRole.municipal) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => MunicipalDashboard(
              authService: authService,
            ),
          );
        }

        // No role
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Error: User role not found.',
              ),
            ),
          ),
        );

    // =========================
    // UNKNOWN ROUTE
    // =========================
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Page not found: ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
