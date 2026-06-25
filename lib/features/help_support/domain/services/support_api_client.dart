import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/api_config.dart';
import '../../../auth/domain/services/user_identity_service.dart';
import '../../data/models/app_rating.dart';
import '../../data/models/support_message.dart';
import '../../data/models/support_ticket.dart';

class SupportApiClient {
  SupportApiClient._();

  static final instance = SupportApiClient._();

  Future<bool> uploadTicket(SupportTicket ticket) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.supportBase}/tickets'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          ...ticket.toMap(),
          'userId': UserIdentityService.instance.userId,
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> uploadMessage(SupportMessage message) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.supportBase}/messages'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          ...message.toMap(),
          'userId': UserIdentityService.instance.userId,
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> uploadRating(AppRating rating) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.supportBase}/ratings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          ...rating.toMap(),
          'userId': UserIdentityService.instance.userId,
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
