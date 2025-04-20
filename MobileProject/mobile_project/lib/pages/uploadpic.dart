import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/services/upload.dart';

class Uploadpic extends StatefulWidget {
  const Uploadpic({super.key});

  @override
  State<Uploadpic> createState() => _UploadpicState();
}

class _UploadpicState extends State<Uploadpic> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    } else {
      print('No image selected');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(context,"Upload"),
        body: Center(
          child: _image != null
              ? Image.memory(_image!)
              : const Text("No image selected"),
        ),
              floatingActionButton: FloatingActionButton(
                onPressed: selectImage,
                backgroundColor: Colors.transparent,
                elevation: 0, //remove shadow naja
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.grey[700]!, // from Figma
                    width: 2,
                  ),
                ),
                tooltip: 'Upload Image',
                child: Icon(Icons.photo_size_select_actual_rounded,color: Colors.grey[700]),
              ),
        );
  }
}
