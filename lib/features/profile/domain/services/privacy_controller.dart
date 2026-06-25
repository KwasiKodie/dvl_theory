import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../../../core/storage/hive_boxes.dart';
import '../../data/models/privacy_settings.dart';

class PrivacyController extends ChangeNotifier {
  PrivacyController._();
  static final instance = PrivacyController._();

  static const _key = 'privacySettings';

  PrivacySettings settings = PrivacySettings.defaults();

  Future<void> load() async {
    final box = Hive.box(HiveBoxes.profile);
    final raw = box.get(_key);

    if (raw == null) {
      settings = PrivacySettings.defaults();
      await box.put(_key, settings.toMap());
    } else {
      settings = PrivacySettings.fromMap(Map.from(raw));
    }

    notifyListeners();
  }

  Future<void> update(PrivacySettings value) async {
    settings = value;

    final box = Hive.box(HiveBoxes.profile);
    await box.put(_key, value.toMap());

    notifyListeners();
  }

  Future<void> setAnalytics(bool value) {
    return update(settings.copyWith(analyticsEnabled: value));
  }

  Future<void> setAds(bool value) {
    return update(settings.copyWith(personalizedAds: value));
  }

  Future<void> setCrashReporting(bool value) {
    return update(settings.copyWith(crashReporting: value));
  }
}