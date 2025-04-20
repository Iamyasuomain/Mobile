import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:mobile_project/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_project/pages/modelresponse.dart';
import 'package:flutter/cupertino.dart';

class Display extends StatelessWidget {
  final String? uploadImagePath;
  final String? capturedImagePath;

  const Display({
    super.key,
    this.uploadImagePath,
    this.capturedImagePath,
  });

  Future<void> sendToML(BuildContext context, XFile images) async {

    showDialog(
      context: context,
      barrierDismissible:false, 
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            width: 250, 
            height: 150, 
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(height: 20),
                Text(
                  "Processing...",
                ),
              ],
            ),
          ),
        );
      },
    );

    String base64Image = '';
    List<int> imageBytes = await XFile(images.path).readAsBytes();
    base64Image = base64Encode(imageBytes);

    final url = Uri.parse(
        'https://serverless.roboflow.com/infer/workflows/midnightmiracle/detect-count-and-visualize-2');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'api_key': 'vZjkndB0RQFlzqhYsKp6',
      'inputs': {
        'image': {
          'type': 'base64',
          'value': base64Image, // Replace this with the actual image URL
        },
      },
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {

      Navigator.pop(context);
      
      final result = jsonDecode(response.body);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Modelresponse(predicted: result)));
    } else {
      print('Error: ${response.statusCode}');
    }
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
                    await sendToML(context, image);
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
