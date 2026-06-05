import 'package:hive_flutter/hive_flutter.dart';
import 'hive_boxes.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(HiveBoxes.profile);

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
