import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> uploadImage(String inputSource) async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
