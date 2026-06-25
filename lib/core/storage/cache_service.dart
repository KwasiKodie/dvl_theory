import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static Future<double> getCacheSizeMB() async {
    final dir = await getTemporaryDirectory();
    return _getDirSize(dir) / (1024 * 1024);
  }

  static Future<void> clearCache() async {
    final dir = await getTemporaryDirectory();

    if (dir.existsSync()) {
      for (var file in dir.listSync()) {
        file.deleteSync(recursive: true);
      }
    }
  }

  static double _getDirSize(Directory dir) {
    double size = 0;

    for (var file in dir.listSync(recursive: true)) {
      if (file is File) {
        size += file.lengthSync();
      }
    }

    return size;
  }
}