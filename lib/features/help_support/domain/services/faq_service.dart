import 'dart:convert';

import 'package:flutter/services.dart';

import '../../data/models/faq_item.dart';

class FaqService {
  FaqService._();

  static final FaqService instance = FaqService._();

  List<FaqItem>? _cache;

  Future<List<FaqItem>> loadFaqs() async {
    if (_cache != null) return _cache!;

    final jsonString = await rootBundle.loadString('assets/data/faqs.json');

    final decoded = json.decode(jsonString);

    final List<dynamic> rawList = decoded is List
        ? decoded
        : decoded['faqs'] as List<dynamic>;

    _cache = rawList
        .map((item) => FaqItem.fromMap(Map<String, dynamic>.from(item)))
        .toList();

    return _cache!;
  }
}
