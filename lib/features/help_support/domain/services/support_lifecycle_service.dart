import 'package:flutter/widgets.dart';

import 'support_sync_service.dart';

class SupportLifecycleService with WidgetsBindingObserver {
  SupportLifecycleService._();

  static final instance = SupportLifecycleService._();

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SupportSyncService.instance.syncAll();
    }
  }
}
