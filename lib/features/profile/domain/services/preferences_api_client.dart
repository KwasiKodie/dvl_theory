import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/api_config.dart';
import '../../../auth/domain/services/user_identity_service.dart';
import '../../data/models/study_preferences.dart';

class PreferencesApiClient {
  PreferencesApiClient._();

  static final instance = PreferencesApiClient._();

  Future<bool> uploadPreferences(
    StudyPreferences preferences,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ApiConfig.baseUrl}/api/study-preference',
        ),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId':
              UserIdentityService.instance.userId,
          ...preferences.toApiMap(),
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<StudyPreferences?> downloadPreferences() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/api/study-preference/'
          '${UserIdentityService.instance.userId}',
        ),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final json =
          jsonDecode(response.body)
              as Map<String, dynamic>;

      final data =
          json['studyPreference'];

      if (data == null) {
        return null;
      }

      return StudyPreferences.fromMap(
        Map<String, dynamic>.from(data),
      );
    } catch (_) {
      return null;
    }
  }
}