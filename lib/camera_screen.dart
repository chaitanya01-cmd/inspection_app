import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gal/gal.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  int _selectedCameraIndex = 0;
  
  FlashMode _currentFlashMode = FlashMode.off;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  double _currentZoom = 1.0;
  bool _isRecording = false;
  
  final List<String> _savedMediaPaths = [];

  @override
  void initState() {
    super.initState();
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    controller = CameraController(widget.cameras[cameraIndex], ResolutionPreset.max);
    try {
      await controller.initialize();
      _minZoom = await controller.getMinZoomLevel();
      _maxZoom = await controller.getMaxZoomLevel();
      _currentZoom = _minZoom;
      _currentFlashMode = controller.value.flashMode;
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _toggleCamera() async {
    if (widget.cameras.length < 2) return;
    _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    await controller.dispose();
    await _initCamera(_selectedCameraIndex);
  }

  Future<void> _cycleFlashMode() async {
    FlashMode nextMode;
    switch (_currentFlashMode) {
      case FlashMode.off:
        nextMode = FlashMode.auto;
        break;
      case FlashMode.auto:
        nextMode = FlashMode.always;
        break;
      case FlashMode.always:
        nextMode = FlashMode.torch;
        break;
      default:
        nextMode = FlashMode.off;
    }
    await controller.setFlashMode(nextMode);
    setState(() {
      _currentFlashMode = nextMode;
    });
  }

  IconData _getFlashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.highlight;
      default:
        return Icons.flash_off;
    }
  }

  Future<void> _takePicture() async {
    try {
      final image = await controller.takePicture();
      _savedMediaPaths.add(image.path);
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayMediaScreen(
            mediaPath: image.path,
            isVideo: false,
          ),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _toggleVideoRecording() async {
    if (_isRecording) {
      try {
        final video = await controller.stopVideoRecording();
        setState(() => _isRecording = false);
        _savedMediaPaths.add(video.path);
        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayMediaScreen(
              mediaPath: video.path,
              isVideo: true,
            ),
          ),
        );
      } catch (e) {
        print('Error stopping video: $e');
      }
    } else {
      try {
        await controller.startVideoRecording();
        setState(() => _isRecording = true);
      } catch (e) {
        print('Error starting video: $e');
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isRecording ? 'Recording...' : 'Photo Evidence Camera'),
        backgroundColor: _isRecording ? Colors.red.shade900 : null,
        actions: [
          IconButton(
            icon: Icon(_getFlashIcon()),
            onPressed: _cycleFlashMode,
            tooltip: 'Flash Mode',
          ),
          if (widget.cameras.length > 1)
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: _toggleCamera,
              tooltip: 'Switch Camera',
            ),
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryScreen(paths: _savedMediaPaths),
                ),
              );
            },
            tooltip: 'In-App Gallery',
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(controller)),
          Positioned(
            right: 10,
            top: 50,
            bottom: 120,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: _currentZoom,
                min: _minZoom,
                max: _maxZoom,
                onChanged: (value) async {
                  setState(() => _currentZoom = value);
                  await controller.setZoomLevel(value);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'photoBtn',
                  onPressed: _isRecording ? null : _takePicture,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                ),
                FloatingActionButton(
                  heroTag: 'videoBtn',
                  onPressed: _toggleVideoRecording,
                  backgroundColor: _isRecording ? Colors.red : Colors.redAccent,
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.videocam,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayMediaScreen extends StatelessWidget {
  final String mediaPath;
  final bool isVideo;

  const DisplayMediaScreen({
    super.key,
    required this.mediaPath,
    required this.isVideo,
  });

  Future<void> _saveToGallery(BuildContext context) async {
    try {
      if (isVideo) {
        await Gal.putVideo(mediaPath);
      } else {
        await Gal.putImage(mediaPath);
      }
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to Device Gallery!')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isVideo ? 'Video Preview' : 'Photo Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () => _saveToGallery(context),
            tooltip: 'Save to Gallery',
          ),
        ],
      ),
      body: Center(
        child: isVideo
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.movie, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text('Video saved:\n$mediaPath', textAlign: TextAlign.center),
                ],
              )
            : Image.file(File(mediaPath)),
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  final List<String> paths;

  const GalleryScreen({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Captured Evidence')),
      body: paths.isEmpty
          ? const Center(child: Text('No evidence captured yet.'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: paths.length,
              itemBuilder: (context, index) {
                final path = paths[index];
                final isVideo = path.endsWith('.mp4');
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    isVideo
                        ? Container(
                            color: Colors.black87,
                            child: const Icon(Icons.play_circle, color: Colors.white, size: 40),
                          )
                        : Image.file(File(path), fit: BoxFit.cover),
                  ],
                );
              },
            ),
    );
  }
}