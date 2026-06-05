import 'package:flutter/material.dart';

import '../../domain/services/profile_photo_service.dart';
import '../../domain/services/user_profile_controller.dart';

class ProfilePhotoSheet extends StatelessWidget {
  const ProfilePhotoSheet({super.key});

  Future<void> _pickFromGallery(BuildContext context) async {
    final path = await ProfilePhotoService.instance.pickFromGallery();

    if (path == null) return;

    await UserProfileController.instance.updateProfileImage(path);

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  Future<void> _takePhoto(BuildContext context) async {
    final path = await ProfilePhotoService.instance.takePhoto();

    if (path == null) return;

    await UserProfileController.instance.updateProfileImage(path);

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  Future<void> _removePhoto(BuildContext context) async {
    final controller = UserProfileController.instance;

    await ProfilePhotoService.instance.deletePhoto(controller.profileImagePath);

    await controller.removeProfileImage();

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () => _takePhoto(context),
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose From Gallery'),
                onTap: () => _pickFromGallery(context),
              ),

              ListTile(
                leading: Icon(Icons.delete, color: theme.colorScheme.error),
                title: Text(
                  'Remove Photo',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                onTap: () => _removePhoto(context),
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
