import 'dart:io';

import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import '../../data/models/app_rating.dart';
import '../../data/models/support_message.dart';
import '../../data/models/support_ticket.dart';
import 'support_sync_service.dart';

class SupportService {
  SupportService._();

  static final SupportService instance = SupportService._();

  Box get _ticketBox => Hive.box(HiveBoxes.supportTickets);
  Box get _messageBox => Hive.box(HiveBoxes.supportMessages);
  Box get _ratingBox => Hive.box(HiveBoxes.appRatings);

  Future<void> submitTicket({
    required String category,
    required String description,
  }) async {
    final ticket = SupportTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      category: category.trim(),
      description: description.trim(),
      platform: Platform.operatingSystem,
      appVersion: '1.0.0',
      uploaded: false,
      syncAttempts: 0,
      lastSyncAttempt: null,
    );

    await _ticketBox.put(ticket.id, ticket.toMap());
    await SupportSyncService.instance.syncAll();
  }

  Future<void> submitMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final supportMessage = SupportMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
      email: email.trim(),
      subject: subject.trim(),
      message: message.trim(),
      platform: Platform.operatingSystem,
      appVersion: '1.0.0',
      uploaded: false,
      syncAttempts: 0,
      lastSyncAttempt: null,
    );

    await _messageBox.put(supportMessage.id, supportMessage.toMap());
    await SupportSyncService.instance.syncAll();
  }

  Future<void> submitRating({
    required int stars,
    required String feedback,
  }) async {
    final rating = AppRating(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      stars: stars,
      feedback: feedback.trim(),
      platform: Platform.operatingSystem,
      appVersion: '1.0.0',
      uploaded: false,
      syncAttempts: 0,
      lastSyncAttempt: null,
    );

    await _ratingBox.put(rating.id, rating.toMap());
    await SupportSyncService.instance.syncAll();
  }

  Future<void> markTicketUploaded(String id) async {
    final raw = _ticketBox.get(id);
    if (raw == null) return;

    final ticket = SupportTicket.fromMap(Map<dynamic, dynamic>.from(raw));

    await _ticketBox.put(
      id,
      ticket.copyWith(uploaded: true, lastSyncAttempt: DateTime.now()).toMap(),
    );
  }

  Future<void> markMessageUploaded(String id) async {
    final raw = _messageBox.get(id);
    if (raw == null) return;

    final message = SupportMessage.fromMap(Map<dynamic, dynamic>.from(raw));

    await _messageBox.put(
      id,
      message.copyWith(uploaded: true, lastSyncAttempt: DateTime.now()).toMap(),
    );
  }

  Future<void> markRatingUploaded(String id) async {
    final raw = _ratingBox.get(id);
    if (raw == null) return;

    final rating = AppRating.fromMap(Map<dynamic, dynamic>.from(raw));

    await _ratingBox.put(
      id,
      rating.copyWith(uploaded: true, lastSyncAttempt: DateTime.now()).toMap(),
    );
  }

  Future<void> markTicketFailed(String id) async {
    final raw = _ticketBox.get(id);
    if (raw == null) return;

    final ticket = SupportTicket.fromMap(Map<dynamic, dynamic>.from(raw));

    await _ticketBox.put(
      id,
      ticket
          .copyWith(
            syncAttempts: ticket.syncAttempts + 1,
            lastSyncAttempt: DateTime.now(),
          )
          .toMap(),
    );
  }

  Future<void> markMessageFailed(String id) async {
    final raw = _messageBox.get(id);
    if (raw == null) return;

    final message = SupportMessage.fromMap(Map<dynamic, dynamic>.from(raw));

    await _messageBox.put(
      id,
      message
          .copyWith(
            syncAttempts: message.syncAttempts + 1,
            lastSyncAttempt: DateTime.now(),
          )
          .toMap(),
    );
  }

  Future<void> markRatingFailed(String id) async {
    final raw = _ratingBox.get(id);
    if (raw == null) return;

    final rating = AppRating.fromMap(Map<dynamic, dynamic>.from(raw));

    await _ratingBox.put(
      id,
      rating
          .copyWith(
            syncAttempts: rating.syncAttempts + 1,
            lastSyncAttempt: DateTime.now(),
          )
          .toMap(),
    );
  }

  List<SupportMessage> getMessages() {
    return _messageBox.values
        .map((item) => SupportMessage.fromMap(Map<dynamic, dynamic>.from(item)))
        .toList();
  }

  List<SupportMessage> getPendingMessages() {
    return getMessages().where((message) => !message.uploaded).toList();
  }

  List<AppRating> getRatings() {
    return _ratingBox.values
        .map((item) => AppRating.fromMap(Map<dynamic, dynamic>.from(item)))
        .toList();
  }

  List<AppRating> getPendingRatings() {
    return getRatings().where((rating) => !rating.uploaded).toList();
  }

  List<SupportTicket> getTickets() {
    return _ticketBox.values
        .map((item) => SupportTicket.fromMap(Map<dynamic, dynamic>.from(item)))
        .toList();
  }

  List<SupportTicket> getPendingTickets() {
    return getTickets().where((ticket) => !ticket.uploaded).toList();
  }
}
