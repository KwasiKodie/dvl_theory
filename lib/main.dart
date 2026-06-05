import 'package:flutter/material.dart';

import 'core/navigation/app_router.dart';
import 'core/navigation/route_names.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/theme_mode_storage.dart';
import 'core/storage/hive_service.dart';
import 'features/profile/domain/services/user_profile_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController(storage: ThemeModeStorage());

  await themeController.initialize();

  await HiveService.init();

  await UserProfileController.instance.loadProfile();

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
