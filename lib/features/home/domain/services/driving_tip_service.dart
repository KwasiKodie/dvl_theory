import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class DrivingTipService {
  DrivingTipService._();

  static final DrivingTipService instance = DrivingTipService._();

  List<String>? _cachedTips;

  Future<List<String>> _loadTips() async {
    if (_cachedTips != null) {
      return _cachedTips!;
    }

    final jsonString = await rootBundle.loadString(
      'assets/data/driving_tips.json',
    );

    final Map<String, dynamic> data = json.decode(jsonString);

    final List<dynamic> tips = data['tips'] as List<dynamic>;

    _cachedTips = tips.map((e) => e.toString()).toList();

    return _cachedTips!;
  }

  Future<String> getRandomTip() async {
    final tips = await _loadTips();

    if (tips.isEmpty) {
      return 'Always stay alert and obey road signs.';
    }

    return tips[Random().nextInt(tips.length)];
  }

  Future<String> getTipOfTheDay() async {
    final tips = await _loadTips();

    if (tips.isEmpty) {
      return 'Always stay alert and obey road signs.';
    }

    final today = DateTime.now();

    final seed = today.year * 10000 + today.month * 100 + today.day;

    return tips[seed % tips.length];
  }
}
