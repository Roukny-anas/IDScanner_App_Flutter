import 'dart:io'; // Import the dart:io library for File class
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class IDScannerPage extends StatefulWidget {
  @override
  _IDScannerPageState createState() => _IDScannerPageState();
}

class _IDScannerPageState extends State<IDScannerPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isLoading = false;
  String? _capturedImagePath; // Store the path of the captured image

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras!.first,
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();
    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> _takePicture() async {
    if (!isCameraInitialized) return;

    setState(() {
      isLoading = true;
    });

    try {
      final XFile picture = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = picture.path; // Store the captured image path
      });
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              const Text(
                'ID Scanner',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E8B57),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Scan your ID to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3CB371),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(8.0), // Reduced padding to make the preview larger
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (_capturedImagePath != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5, // Set a fixed height for the preview
                        child: Image.file(
                          File(_capturedImagePath!), // Display the captured image
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (isCameraInitialized)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5, // Set a fixed height for the preview
                        child: AspectRatio(
                          aspectRatio: _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                      )
                    else
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: isLoading ? null : _takePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E8B57),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Scan', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}