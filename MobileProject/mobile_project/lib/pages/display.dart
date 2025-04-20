import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:mobile_project/main.dart';
import 'package:http/http.dart' as http;

class Display extends StatelessWidget {
  final String? uploadImagePath;
  final String? capturedImagePath;

  const Display({
    super.key,
    this.uploadImagePath,
    this.capturedImagePath,
  });

  Future<void> sendToML(XFile images) async {
    String path = images.path;
  }


  @override
  Widget build(BuildContext context) {
    Widget content;

    if (uploadImagePath != null) {
      content = Image.file(
        File(uploadImagePath!),
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
            top: 125,
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
          if (uploadImagePath != null || capturedImagePath != null)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () async {
                  XFile? image;

                  if (uploadImagePath != null) {
                    image = XFile(uploadImagePath!);
                  } else if (capturedImagePath != null) {
                    image = XFile(capturedImagePath!);
                  }

                  if (image != null) {
                    await sendToML(image);
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