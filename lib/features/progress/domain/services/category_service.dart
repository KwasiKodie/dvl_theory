import 'package:hive/hive.dart';
import '../../../../core/storage/hive_boxes.dart';

class CategoryService {
  final Box categoryBox = Hive.box(HiveBoxes.category);

  List<Map<String, dynamic>> getCategoryStats() {
    return categoryBox.keys.map((key) {
      final data = categoryBox.get(key);

      int attempted = data["attempted"];
      int correct = data["correct"];

      double accuracy = (correct / attempted) * 100;

      return {"category": key, "accuracy": accuracy};
    }).toList();
  }
}
