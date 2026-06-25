import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import 'preferences_api_client.dart';
import 'study_preferences_controller.dart';

class PreferencesSyncService {
  PreferencesSyncService._();

  static final instance = PreferencesSyncService._();

  static const _lastSyncKey = 'last_preferences_sync';

  static const _dirtyKey = 'study_preferences_dirty';

  Future<void> markDirty() async {
    final box = Hive.box(HiveBoxes.progressSync);
    await box.put(_dirtyKey, true);
  }

  Future<void> uploadIfDirty() async {
    final box = Hive.box(HiveBoxes.progressSync);
    final dirty = box.get(_dirtyKey, defaultValue: false) == true;

    if (!dirty) return;

    await uploadPreferences();

    await box.put(_dirtyKey, false);
  }

  Future<void> uploadPreferences() async {
    final prefs = StudyPreferencesController.instance.preferences;

    final success = await PreferencesApiClient.instance.uploadPreferences(
      prefs,
    );

    if (!success) return;

    final syncBox = Hive.box(HiveBoxes.progressSync);

    await syncBox.put(_lastSyncKey, DateTime.now().toIso8601String());
  }

  Future<void> restorePreferences() async {
    final prefs = await PreferencesApiClient.instance.downloadPreferences();

    if (prefs == null) return;

    await StudyPreferencesController.instance.restore(prefs);
  }
}
