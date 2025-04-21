import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:camera/camera.dart';
import 'display.dart';
import 'package:mobile_project/main.dart';

class Uploadpic extends StatefulWidget {
  const Uploadpic({super.key});

  @override
  State<Uploadpic> createState() => _UploadpicState();
}

class _UploadpicState extends State<Uploadpic> {
  CameraController? _cameraController;
  bool _isCameraReady = false;
  XFile? _capturedImage;
  XFile? _pickedImage;
  int camera = 0;

  @override
  void initState() {
    super.initState();
    _initCamera(camera);
  }

  void changecamera() async {
    camera == 0 ? camera = 1 : camera = 0;
    await _cameraController?.dispose();
    setState(() {
      _isCameraReady = false;
    });
    _initCamera(camera);
  }

  Future<void> _initCamera(camera) async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras[camera],
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await _cameraController!.initialize();
      setState(() {
        _isCameraReady = true;
      });
    } catch (e) {
      print("Camera error: $e");
    }
  }

  Future<void> captureImage() async {
    try {
      if (!_cameraController!.value.isInitialized ||
          _cameraController!.value.isTakingPicture) return;

      final captureimage = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = captureimage;
        _pickedImage = null;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Display(capturedImagePath: captureimage.path),
        ),
      );
    } catch (e) {
      print("Capture error: $e");
    }
  }

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? uploadimage = await picker.pickImage(source: ImageSource.gallery);
    if (uploadimage != null) {
      setState(() {
        _pickedImage = uploadimage;
        _capturedImage = null;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Display(uploadImagePath: uploadimage.path),
        ),
      );
    } else {
      print('No image selected');
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Nav(text: "Take a picture"),
      ),
      body: _isCameraReady && _cameraController != null
          ? MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(_cameraController!),
                  Positioned(
                    bottom: 95,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: FloatingActionButton(
                      onPressed: captureImage,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.grey[100]!, width: 2),
                      ),
                      tooltip: 'Capture image',
                      child: Icon(Icons.camera_alt_rounded,
                          color: Colors.grey[100]),
                    ),
                  ),
                  Positioned(
                    height: 40,
                    width: 40,
                    top: 125,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: FloatingActionButton(
                      onPressed: changecamera,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.grey[100]!, width: 2),
                      ),
                      tooltip: 'Switch Camera',
                      child: Icon(Icons.cameraswitch, color: Colors.grey[100]),
                    ),
                  ),
                  Positioned(
                    bottom: 95,
                    right: 30,
                    child: FloatingActionButton(
                      onPressed: selectImage,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.grey[100]!, width: 2),
                      ),
                      tooltip: 'Upload Image',
                      child: Icon(Icons.photo_size_select_actual_rounded,
                          color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
