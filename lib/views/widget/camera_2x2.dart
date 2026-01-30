import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

import '_widget.dart';
import 'appbar/_appbar.dart';

class Camera2x2Screen extends StatefulWidget {
  const Camera2x2Screen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<Camera2x2Screen> createState() => _Camera2x2ScreenState();
}

class _Camera2x2ScreenState extends State<Camera2x2Screen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final imageFile = await _controller!.takePicture();

      final bytes = await File(imageFile.path).readAsBytes();
      final decoded = img.decodeImage(bytes)!;

      /// ✅ Resize to 600x600 px
      final resized = img.copyResize(decoded, width: 600, height: 600);
      final jpg = img.encodeJpg(resized, quality: 80);

      final dir = await getTemporaryDirectory();
      final newPath = '${dir.path}/2x2_photo.jpg';
      final newFile = File(newPath);
      await newFile.writeAsBytes(jpg);

      /// Return result to previous screen
      if (mounted) {
        Navigator.pop(context, newFile);
      }
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context,
        title: 'Capture 2x2 Photo',
        isHideBackButton: true,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1, // square preview
                      child: CameraPreview(_controller!),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera),
                  label: const Text("Capture"),
                ),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return LoadingCircularProgress();
          }
        },
      ),
    );
  }
}
