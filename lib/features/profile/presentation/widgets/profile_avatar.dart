import 'package:flutter/material.dart';
import '../../domain/services/user_profile_controller.dart';
import 'dart:io';

class ProfileAvatar extends StatelessWidget {
  final double radius;

  const ProfileAvatar({super.key, this.radius = 36});

  @override
  Widget build(BuildContext context) {
    final controller = UserProfileController.instance;

    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final imagePath = controller.profileImagePath;

        return CircleAvatar(
          radius: radius,

          backgroundImage: imagePath != null
              ? FileImage(File(imagePath))
              : null,

          child: imagePath == null ? Icon(Icons.person, size: radius) : null,
        );
      },
    );
  }
}
