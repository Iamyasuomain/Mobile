import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? uploadpic = await picker.pickImage(source: source);
  return uploadpic;
}
