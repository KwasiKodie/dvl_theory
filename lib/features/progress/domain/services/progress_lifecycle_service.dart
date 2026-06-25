import 'package:flutter/widgets.dart';

import 'progress_sync_service.dart';

class ProgressLifecycleService with WidgetsBindingObserver {
  ProgressLifecycleService._();

  static final instance = ProgressLifecycleService._();

  bool _initialized = false;

  void initialize() {
    if (_initialized) return;

    WidgetsBinding.instance.addObserver(this);

    _initialized = true;
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    if (state == AppLifecycleState.resumed) {
      ProgressSyncService.instance.uploadProgress();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}