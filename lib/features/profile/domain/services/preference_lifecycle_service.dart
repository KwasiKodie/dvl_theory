import 'package:flutter/material.dart';
import 'preferences_sync_service.dart';

class PreferenceLifecycleService
    with WidgetsBindingObserver {
  PreferenceLifecycleService._();

  static final instance =
      PreferenceLifecycleService._();

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      PreferencesSyncService.instance
          .uploadIfDirty();
    }

    if (state == AppLifecycleState.resumed) {
      PreferencesSyncService.instance
          .uploadIfDirty();
    }
  }
}