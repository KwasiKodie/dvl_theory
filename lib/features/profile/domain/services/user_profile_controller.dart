import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:dvl_theory/core/storage/hive_boxes.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileController._();

  static final UserProfileController instance = UserProfileController._();

  String fullName = 'Edit Name';
  String email = 'edit.name@email.com';
  DateTime dateOfBirth = DateTime(1998, 5, 15);
  String phoneNumber = '+233 (0) XXX XXX XXX';
  String? profileImagePath;

  Future<void> updateProfile({
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    required String phoneNumber,
  }) async {
    this.fullName = fullName.trim();
    this.email = email.trim();
    this.dateOfBirth = dateOfBirth;
    this.phoneNumber = phoneNumber.trim();

    final box = Hive.box(HiveBoxes.profile);

    await box.put('fullName', this.fullName);
    await box.put('email', this.email);
    await box.put('dateOfBirth', this.dateOfBirth.toIso8601String());
    await box.put('phoneNumber', this.phoneNumber);

    notifyListeners();
  }

  Future<void> loadProfile() async {
    final box = Hive.box(HiveBoxes.profile);

    fullName = box.get('fullName', defaultValue: 'Your Name');

    email = box.get('email', defaultValue: 'your.name@email.com');

    phoneNumber = box.get('phoneNumber', defaultValue: '+233 (0) XXX XXX XXX');

    profileImagePath = box.get('profileImagePath');

    final dobString = box.get('dateOfBirth');

    if (dobString != null) {
      dateOfBirth = DateTime.parse(dobString);
    }

    notifyListeners();
  }

  Future<void> updateProfileImage(String path) async {
    profileImagePath = path;

    final box = Hive.box(HiveBoxes.profile);
    await box.put('profileImagePath', path);

    notifyListeners();
  }

  Future<void> removeProfileImage() async {
    profileImagePath = null;

    final box = Hive.box(HiveBoxes.profile);
    await box.delete('profileImagePath');

    notifyListeners();
  }

  String get firstName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? fullName : parts.first;
  }

  String get formattedDob {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${dateOfBirth.day} ${months[dateOfBirth.month - 1]} ${dateOfBirth.year}';
  }
}
