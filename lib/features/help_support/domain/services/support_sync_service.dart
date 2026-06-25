import 'connectivity_service.dart';
import 'support_api_client.dart';
import 'support_service.dart';

class SupportSyncService {
  SupportSyncService._();

  static final instance = SupportSyncService._();
  final SupportService _supportService = SupportService.instance;

  int pendingCount = 0;
  int uploadedCount = 0;
  int failedCount = 0;

  int get pendingUploads {
    return _supportService.getPendingTickets().length +
        _supportService.getPendingMessages().length +
        _supportService.getPendingRatings().length;
  }

  int get successfulUploads {
    return _supportService.getTickets().where((e) => e.uploaded).length +
        _supportService.getMessages().where((e) => e.uploaded).length +
        _supportService.getRatings().where((e) => e.uploaded).length;
  }

  int get failedUploads {
    return _supportService
            .getTickets()
            .where((e) => !e.uploaded && e.syncAttempts > 0)
            .length +
        _supportService
            .getMessages()
            .where((e) => !e.uploaded && e.syncAttempts > 0)
            .length +
        _supportService
            .getRatings()
            .where((e) => !e.uploaded && e.syncAttempts > 0)
            .length;
  }

  Future<void> syncAll() async {
    pendingCount = 0;
    uploadedCount = 0;
    failedCount = 0;

    final connected = await ConnectivityService.instance.isConnected();

    if (!connected) {
      return;
    }

    await _syncTickets();
    await _syncMessages();
    await _syncRatings();
  }

  Future<void> _syncTickets() async {
    final tickets = SupportService.instance.getPendingTickets();

    pendingCount += tickets.length;

    for (final ticket in tickets) {
      final success = await SupportApiClient.instance.uploadTicket(ticket);

      if (success) {
        await SupportService.instance.markTicketUploaded(ticket.id);

        uploadedCount++;
      } else {
        await SupportService.instance.markTicketFailed(ticket.id);

        failedCount++;
      }
    }
  }

  Future<void> _syncMessages() async {
    final messages = SupportService.instance.getPendingMessages();

    pendingCount += messages.length;

    for (final message in messages) {
      final success = await SupportApiClient.instance.uploadMessage(message);

      if (success) {
        await SupportService.instance.markMessageUploaded(message.id);

        uploadedCount++;
      } else {
        await SupportService.instance.markMessageFailed(message.id);

        failedCount++;
      }
    }
  }

  Future<void> _syncRatings() async {
    final ratings = SupportService.instance.getPendingRatings();

    pendingCount += ratings.length;

    for (final rating in ratings) {
      final success = await SupportApiClient.instance.uploadRating(rating);

      if (success) {
        await SupportService.instance.markRatingUploaded(rating.id);

        uploadedCount++;
      } else {
        await SupportService.instance.markRatingFailed(rating.id);

        failedCount++;
      }
    }
  }
}
