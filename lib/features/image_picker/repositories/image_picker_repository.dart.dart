import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerRepositoryProvider = Provider<ImagePickerRepository>((ref) {
  return ImagePickerRepository();
});

class ImagePickerRepository {
  final _imagePicker = ImagePicker();

  Future<Uint8List?> pickImageFromCamera() async {
    final file = await _imagePicker.pickImage(source: ImageSource.camera);
    return await file?.readAsBytes();
  }

  Future<Uint8List?> pickImageFromGallery() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    return await file?.readAsBytes();
  }
}
