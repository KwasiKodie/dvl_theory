import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/mock_configuration_tile.dart';
import '../widgets/mock_exam_header.dart';
import '../widgets/mock_info_card.dart';
import '../../../../core/navigation/route_names.dart';
import '../../domain/services/mock_session_controller.dart';
import '../../../profile/domain/services/study_preferences_controller.dart';

class MockIntroScreen extends StatelessWidget {
  const MockIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = MockSessionController.instance.buildConfiguration();

    final duration =
        StudyPreferencesController.instance.preferences.mockDurationMinutes;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: theme.colorScheme.background,
        title: const Text('Mock Exam'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final contentWidth = width > 700 ? 600.0 : width;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
                  child: Column(
                    children: [
                      const MockExamHeader(),

                      const SizedBox(height: 28),

                      MockConfigurationTile(
                        title: 'Number of Questions',
                        value: '${config.questionCount} Questions',
                      ),

                      MockConfigurationTile(
                        title: 'Test Mode',
                        value: '$duration Minutes',
                      ),

                      const MockConfigurationTile(
                        title: 'Random Questions',
                        value: 'Enabled',
                      ),

                      MockConfigurationTile(
                        title: 'Passing Score',
                        value:
                            '${config.passingScore} / ${config.questionCount}',
                      ),

                      const SizedBox(height: 30),

                      const MockInfoCard(),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.mockInstructions,
                            );
                          },
                          child: const Text('Instructions'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
