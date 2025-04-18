import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? _file = await picker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image Selected');
}
