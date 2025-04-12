import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescription Scanner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CameraScreen(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _extractedText;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _captureAndRecognizeText() async {
    try {
      // Request permissions
      if (await _requestPermissions() != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissions denied')),
        );
        return;
      }

      // Take a picture
      final XFile photo = await _controller.takePicture();

      // Get the file path
      final filePath = photo.path;

      // Load the image into InputImage
      final inputImage = InputImage.fromFilePath(filePath);

      // Initialize the text recognizer
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

      // Process the image
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      // Extract text
      String extractedText = '';
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          extractedText += line.text + '\n';
        }
      }

      // Close the text recognizer
      textRecognizer.close();

      // Update the UI with the extracted text
      setState(() {
        _extractedText = extractedText.isEmpty ? 'No text found' : extractedText;
      });
    } catch (e) {
      print('Error during text recognition: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to extract text: $e')),
      );
    }
  }

  Future<bool> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prescription Scanner')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _captureAndRecognizeText,
              child: Text('Scan Prescription'),
            ),
          ),
          if (_extractedText != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Extracted Text:\n$_extractedText',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}