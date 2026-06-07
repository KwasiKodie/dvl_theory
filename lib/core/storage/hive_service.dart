import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.profile);
    await Hive.openBox(HiveBoxes.studyPreferences);
    await Hive.openBox(HiveBoxes.notificationPreferences);
    await Hive.openBox(HiveBoxes.notifications);

    // Open all boxes BEFORE app starts
    await Future.wait([
      Hive.openBox(HiveBoxes.attempts),
      Hive.openBox(HiveBoxes.stats),
      Hive.openBox(HiveBoxes.category),
      Hive.openBox(HiveBoxes.wrong),
      Hive.openBox(HiveBoxes.mastery),
      Hive.openBox(HiveBoxes.review),
      Hive.openBox(HiveBoxes.streak),
    ]);
  }
}
