import 'package:flutter/material.dart';

import 'services/auth_service.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Municipal Inspection System',

      theme: AppTheme.lightTheme,

      initialRoute: '/',

      onGenerateRoute: (settings) {
        return AppRoutes.generateRoute(
          settings,
          authService,
        );
      },
    );
  }
}
