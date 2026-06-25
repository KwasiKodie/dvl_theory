import 'package:flutter/material.dart';
import 'dart:io';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import 'core/navigation/app_router.dart';
import 'core/navigation/route_names.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/theme_mode_storage.dart';
import 'core/storage/hive_service.dart';
import 'features/profile/domain/services/user_profile_controller.dart';
import 'features/profile/domain/services/study_preferences_controller.dart';
import 'features/profile/domain/services/notification_preferences_controller.dart';
import 'features/notifications/domain/services/local_notification_service.dart';
import 'features/notifications/domain/services/reminder_engine.dart';
import 'features/help_support/domain/services/support_sync_service.dart';
import 'features/help_support/domain/services/support_lifecycle_service.dart';
import 'features/progress/domain/services/progress_sync_service.dart';
import 'features/progress/domain/services/progress_lifecycle_service.dart';
import 'features/profile/domain/services/preferences_sync_service.dart';
import 'features/profile/domain/services/preference_lifecycle_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController(storage: ThemeModeStorage());

  await themeController.initialize();

  await HiveService.init();

  SupportLifecycleService.instance.initialize();
  ProgressLifecycleService.instance.initialize();
  PreferenceLifecycleService.instance.initialize();

  await UserProfileController.instance.loadProfile();
  await StudyPreferencesController.instance.load();
  await NotificationPreferencesController.instance.load();

  await PreferencesSyncService.instance.restorePreferences();
  await ProgressSyncService.instance.restoreProgress();

  await SupportSyncService.instance.syncAll();

  await PreferencesSyncService.instance.uploadIfDirty();

  tzdata.initializeTimeZones();

  try {
    final timezone = await FlutterTimezone.getLocalTimezone();

    String timezoneName = timezone.identifier;

    if (timezoneName == 'Africa/Accra') {
      timezoneName = 'Africa/Abidjan';
    }

    tz.setLocalLocation(tz.getLocation(timezoneName));
  } catch (_, _) {
    tz.setLocalLocation(tz.getLocation('UTC'));
  }

  if (Platform.isAndroid || Platform.isIOS) {
    await LocalNotificationService.instance.initialize();

    await LocalNotificationService.instance.requestPermissions();

    await ReminderEngine.instance.initialize();
  }

  AppRouter.themeController = themeController;

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return AnimatedTheme(
          data: themeController.themeMode == ThemeMode.dark
              ? AppTheme.dark
              : AppTheme.light,
          duration: const Duration(milliseconds: 300),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DVL Theory',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeController.themeMode,
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
