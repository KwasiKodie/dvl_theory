import 'package:flutter/material.dart';

import 'route_names.dart';
import 'route_transitions.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/account_screen.dart';
import '../../features/profile/presentation/screens/study_preferences_screen.dart';
import '../../features/profile/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/language_screen.dart';
import '../../features/profile/presentation/screens/privacy_security_screen.dart';
import '../../features/profile/presentation/screens/help_support_screen.dart';
import '../../features/profile/presentation/screens/about_screen.dart';
import '../../features/splash/presentation/screens/splash_screen_controller.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/practice/presentation/screens/practice_screen.dart';
import '../../features/practice/presentation/screens/review_screen.dart';
import '../../features/practice/presentation/screens/review_question_detail_screen.dart';
import '../../features/practice/data/models/review_question_arguments.dart';
import '../../features/practice/domain/services/practice_session_controller.dart';
import '../../features/mock/presentation/screens/mock_intro_screen.dart';
import '../../features/mock/presentation/screens/mock_instructions_screen.dart';
import '../../features/mock/presentation/screens/mock_exam_screen.dart';
import '../../features/mock/presentation/screens/mock_summary_screen.dart';
import '../../features/mock/presentation/screens/mock_submit_screen.dart';
import '../../features/mock/presentation/screens/mock_result_screen.dart';
import '../../features/notifications/presentation/screens/notification_center_screen.dart';
import '../../features/help_support/presentation/screens/faq_screen.dart';
import '../../features/help_support/presentation/screens/report_problem_screen.dart';
import '../../features/help_support/presentation/screens/contact_us_screen.dart';
import '../../features/help_support/presentation/screens/rate_app_screen.dart';
import '../../features/help_support/presentation/screens/follow_us_screen.dart';
import '../theme/theme_controller.dart';

class AppRouter {
  const AppRouter._();

  static ThemeController? themeController;

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return RouteTransitions.fadeSlide(const SplashScreenController());

      case RouteNames.home:
        return RouteTransitions.fadeSlide(const HomeScreen());

      case RouteNames.practice:
        return RouteTransitions.fadeSlide(const PracticeScreen());

      case RouteNames.mockIntro:
        return RouteTransitions.fadeSlide(const MockIntroScreen());

      case RouteNames.mockInstructions:
        return RouteTransitions.fadeSlide(const MockInstructionsScreen());

      case RouteNames.mockExam:
        return RouteTransitions.fadeSlide(const MockExamScreen());

      case RouteNames.mockSummary:
        return RouteTransitions.fadeSlide(const MockSummaryScreen());

      case RouteNames.mockSubmit:
        return RouteTransitions.fadeSlide(const MockSubmitScreen());

      case RouteNames.mockResult:
        return RouteTransitions.fadeSlide(const MockResultScreen());

      case RouteNames.settings:
        final controller = themeController;

        if (controller == null) {
          return _errorRoute('ThemeController was not initialized.');
        }

        return RouteTransitions.fadeSlide(
          SettingsScreen(themeController: controller),
        );

      case RouteNames.notificationCenter:
        return RouteTransitions.fadeSlide(const NotificationCenterScreen());

      case RouteNames.profile:
        return RouteTransitions.fadeSlide(const ProfileScreen());

      case RouteNames.progress:
        return RouteTransitions.fadeSlide(const ProgressScreen());

      case RouteNames.account:
        return RouteTransitions.fadeSlide(const AccountScreen());

      case RouteNames.studyPreferences:
        return RouteTransitions.fadeSlide(const StudyPreferencesScreen());

      case RouteNames.notifications:
        return RouteTransitions.fadeSlide(const NotificationsScreen());

      case RouteNames.language:
        return RouteTransitions.fadeSlide(const LanguageScreen());

      case RouteNames.privacySecurity:
        return RouteTransitions.fadeSlide(const PrivacySecurityScreen());

      case RouteNames.helpSupport:
        return RouteTransitions.fadeSlide(const HelpSupportScreen());

      case RouteNames.faq:
        return RouteTransitions.fadeSlide(const FaqScreen());

      case RouteNames.reportProblem:
        return RouteTransitions.fadeSlide(const ReportProblemScreen());

      case RouteNames.contactUs:
        return RouteTransitions.fadeSlide(const ContactUsScreen());

      case RouteNames.rateApp:
        return RouteTransitions.fadeSlide(const RateAppScreen());

      case RouteNames.followUs:
        return RouteTransitions.fadeSlide(const FollowUsScreen());

      case RouteNames.about:
        return RouteTransitions.fadeSlide(const AboutScreen());

      case RouteNames.review:
        return RouteTransitions.fadeSlide(
          ReviewScreen(
            reviewData: settings.arguments as List<ReviewQuestionData>,
          ),
        );

      case RouteNames.reviewQuestion:
        return RouteTransitions.fadeSlide(
          ReviewQuestionDetailScreen(
            args: settings.arguments as ReviewQuestionArguments,
          ),
        );

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text(message))),
    );
  }
}
