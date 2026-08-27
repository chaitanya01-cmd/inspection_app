import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member 4 Feature',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LocationScreen(),
    );
  }
=======
import 'package:camera/camera.dart';
import 'camera_screen.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CameraScreen(cameras: _cameras),
  ));
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
}