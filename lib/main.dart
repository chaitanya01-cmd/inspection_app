import 'package:flutter/material.dart';
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
}