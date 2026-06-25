import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../../core/storage/hive_boxes.dart';
import 'package:hive/hive.dart';

class ExportService {
  static Future<String> exportUserData() async {
    final profileBox = Hive.box(HiveBoxes.profile);
    final progressBox = Hive.box(HiveBoxes.progress);

    final data = {
      'profile': profileBox.toMap(),
      'progress': progressBox.toMap(),
    };

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/dvl_user_data.json');

    await file.writeAsString(jsonEncode(data));

    return file.path;
  }
}