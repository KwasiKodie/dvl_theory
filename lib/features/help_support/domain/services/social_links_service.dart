import 'dart:convert';

import 'package:flutter/services.dart';

class SocialLinksService {
  SocialLinksService._();

  static final SocialLinksService instance = SocialLinksService._();

  Map<String, String>? _cache;

  Future<Map<String, String>> loadLinks() async {
    if (_cache != null) return _cache!;

    final raw = await rootBundle.loadString('assets/data/social_links.json');

    final decoded = Map<String, dynamic>.from(json.decode(raw));

    _cache = decoded.map((key, value) => MapEntry(key, value.toString()));

    return _cache!;
  }
}
