import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/api_config.dart';
import '../../../auth/domain/services/user_identity_service.dart';
import '../../data/models/question_attempt_model.dart';

class ProgressApiClient {
  ProgressApiClient._();

  static final instance = ProgressApiClient._();

  Future<bool> uploadAttempts({
    required List<QuestionAttemptModel> attempts,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.progressBase}/attempts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': UserIdentityService.instance.userId,
          'attempts': attempts.map((e) => e.toMap()).toList(),
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<List<QuestionAttemptModel>> downloadAttempts() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.progressBase}/attempts/'
          '${UserIdentityService.instance.userId}',
        ),
      );

      if (response.statusCode != 200) {
        return [];
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      final attempts = json['attempts'] as List<dynamic>;

      return attempts
          .map(
            (item) =>
                QuestionAttemptModel.fromMap(Map<String, dynamic>.from(item)),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }
}
