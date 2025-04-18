import 'dart:ffi';
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

  Future<void> sendToML(Uint8List imageBytes) async {
    print("Sending image to ML model... size: ${imageBytes.length}");
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (pickedImage != null) {
      content = Image.memory(
        pickedImage!,
        fit: BoxFit.cover, // Makes the image full screen
        width: double.infinity, // Make the width fill the screen
        height: double.infinity, // Make the height fill the screen
      );
    } else if (capturedImagePath != null) {
      content = Image.file(
        File(capturedImagePath!),
        fit: BoxFit.cover, // Makes the image full screen
        width: double.infinity, // Make the width fill the screen
        height: double.infinity, // Make the height fill the screen
      );
    } else {
      content = const Text("No image available");
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBarCustom("Image"),
      body: Stack(
        children: [
          Positioned.fill(child: content),
          Positioned(
            top: 40,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // Pops the current screen
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: CircleBorder(
                side: BorderSide(color: Colors.grey[100]!, width: 2),
              ),
              tooltip: 'Back',
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey[100],
              ),
            ),
          ),

          // Send image button in the bottom-right corner
          if (pickedImage != null || capturedImagePath != null)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.grey[100]!, width: 2),
                ),
                tooltip: 'Send image',
                child: Icon(Icons.send_rounded, color: Colors.grey[100]),
              ),
            ),
        ],
      ),
    );
  }
}

