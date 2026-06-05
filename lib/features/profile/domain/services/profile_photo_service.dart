import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePhotoService {
  ProfilePhotoService._();

  static final ProfilePhotoService instance = ProfilePhotoService._();

  final ImagePicker _picker = ImagePicker();

  Future<String?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return null;

    return _saveImage(File(image.path));
  }

  Future<String?> takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image == null) return null;

    return _saveImage(File(image.path));
  }

  Future<String> _saveImage(File file) async {
    final appDir = await getApplicationDocumentsDirectory();

    final profileDir = Directory('${appDir.path}/profile');

    if (!await profileDir.exists()) {
      await profileDir.create(recursive: true);
    }

    final filePath = '${profileDir.path}/profile_photo.jpg';

    final savedImage = await file.copy(filePath);

    return savedImage.path;
  }

  Future<void> deletePhoto(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) {
      return;
    }

    final file = File(imagePath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
