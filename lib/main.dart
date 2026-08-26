import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'routes/app_routes.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

// Available device cameras.
// This can later be passed to CameraScreen from the inspection form.
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load all available cameras on the device.
  try {
    cameras = await availableCameras();
  } catch (e) {
    cameras = [];
    debugPrint('Could not load cameras: $e');
  }

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