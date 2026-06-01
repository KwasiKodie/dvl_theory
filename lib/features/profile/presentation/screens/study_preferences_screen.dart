import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/study_preference_card.dart';

class StudyPreferencesScreen extends StatelessWidget {
  const StudyPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        title: Text(
          'Study Preferences',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: StudyPreferenceCard(),
            ),
          ),
        ),
      ),
    );
  }
}
