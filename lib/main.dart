import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('APP: main() started');

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
    debugPrint('APP: MyApp build()');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Municipal Inspection System',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        debugPrint('APP: Opening route -> ${settings.name}');

        return AppRoutes.generateRoute(
          settings,
          authService,
        );
      },
    );
  }
}