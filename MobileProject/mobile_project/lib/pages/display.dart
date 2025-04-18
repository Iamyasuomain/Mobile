import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:mobile_project/main.dart';

class Display extends StatelessWidget {
  final Uint8List? pickedImage;
  final String? capturedImagePath;

  const Display({
    super.key,
    this.pickedImage,
    this.capturedImagePath,
  });

  // ===== Mock function for ML Processing =====
  Future<void> sendToML(Uint8List imageBytes) async {
    // TODO: replace with actual ML call
    print("Sending image to ML model... size: ${imageBytes.length}");
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (pickedImage != null) {
      content = Image.memory(pickedImage!);
    } else if (capturedImagePath != null) {
      content = Image.file(File(capturedImagePath!));
    } else {
      content = const Text("No image available");
    }

    return Scaffold(
      appBar: AppBarCustom("Image"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: content)),
          if (pickedImage != null || capturedImagePath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  Uint8List? bytes;

                  if (pickedImage != null) {
                    bytes = pickedImage;
                  } else if (capturedImagePath != null) {
                    bytes = await File(capturedImagePath!).readAsBytes();
                  }

                  if (bytes != null) {
                    await sendToML(bytes);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Image sent to ML model')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text("Send to ML Model"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F5241),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
        ],
      ),
    );
  }
}
