import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../sevices/DocumentService.dart'; // Import the DocumentService

class IDScannerPage extends StatefulWidget {
  @override
  _IDScannerPageState createState() => _IDScannerPageState();
}

class _IDScannerPageState extends State<IDScannerPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isLoading = false;
  bool isFlashOn = false; // Flash toggle state
  String? _capturedImagePath;
  String? _extractedText; // Store the extracted text

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
      enableAudio: false,
    );

    await _cameraController!.initialize();
    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> _toggleFlash() async {
    if (!isCameraInitialized) return;

    try {
      isFlashOn = !isFlashOn;
      await _cameraController!.setFlashMode(
        isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    } catch (e) {
      print('Error toggling flash: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!isCameraInitialized) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Take a picture
      final XFile picture = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = picture.path;
      });

      // Upload the image and get the extracted text
      final documentService = DocumentService(baseUrl: 'http://192.168.1.38:8082');
      final document = await documentService.uploadDocument(_capturedImagePath!);
      
      // Update the state with the extracted text
      setState(() {
        _extractedText = document.extractedData;
      });
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _capturedImagePath = null;
      _extractedText = null;
    });
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
                padding: const EdgeInsets.all(8.0),
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
                child: Stack(
                  alignment: Alignment.center, // Center the "X" button over the image
                  children: [
                    if (_capturedImagePath != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.file(
                          File(_capturedImagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (isCameraInitialized)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: AspectRatio(
                          aspectRatio: _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                      )
                    else
                      const Center(child: CircularProgressIndicator()),
                    if (_capturedImagePath != null)
                      Positioned(
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (_extractedText != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Extracted Text: $_extractedText',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: isLoading ? null : _takePicture,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E8B57),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Scan', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  IconButton(
                    onPressed: isCameraInitialized ? _toggleFlash : null,
                    icon: Icon(
                      isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: isFlashOn ? Colors.yellow : Colors.grey,
                    ),
                    iconSize: 32,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}