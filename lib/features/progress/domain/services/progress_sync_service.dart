// import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/storage/hive_boxes.dart';
import 'progress_api_client.dart';
import '../../data/models/question_attempt_model.dart';

class ProgressSyncService {
  ProgressSyncService._();

  static final instance = ProgressSyncService._();

  static const _lastSyncKey = 'last_progress_sync';

  Box get _attemptBox => Hive.box(HiveBoxes.attempts);
  Box get _syncBox => Hive.box(HiveBoxes.progressSync);

  Future<void> uploadProgress() async {
  final pendingAttempts = <QuestionAttemptModel>[];

  for (final key in _attemptBox.keys) {
    final raw = _attemptBox.get(key);

    if (raw is! Map) continue;

    final map = Map<String, dynamic>.from(raw);

    if (map['uploaded'] == true) continue;

    pendingAttempts.add(
      QuestionAttemptModel.fromMap(map),
    );
  }

  if (pendingAttempts.isEmpty) {
    return;
  }

  final success = await ProgressApiClient.instance.uploadAttempts(
    attempts: pendingAttempts,
  );

  if (!success) return;

  for (final key in _attemptBox.keys) {
    final raw = _attemptBox.get(key);

    if (raw is! Map) continue;

    final map = Map<String, dynamic>.from(raw);

    map['uploaded'] = true;

    await _attemptBox.put(key, map);
  }

  await _syncBox.put(
    _lastSyncKey,
    DateTime.now().toIso8601String(),
  );
}

  Future<void> restoreProgress() async {
    final attempts = await ProgressApiClient.instance.downloadAttempts();

    if (attempts.isEmpty) return;

    await _attemptBox.clear();

    for (final attempt in attempts) {
      await _attemptBox.put(attempt.id, attempt.toMap());
    }

    await _syncBox.put(_lastSyncKey, DateTime.now().toIso8601String());
  }
}
