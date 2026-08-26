import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_screen.dart';
import 'screens/municipal_shell.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MunicipalInspectionApp());
}

class MunicipalInspectionApp extends StatelessWidget {
  const MunicipalInspectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Municipal Inspection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const MunicipalShell(),
      routes: {
        '/camera': (context) => CameraScreen(cameras: cameras),
      },
    );
  }
}