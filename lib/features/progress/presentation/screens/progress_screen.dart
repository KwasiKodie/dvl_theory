import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../../../analytics/domain/services/readiness_service.dart';

import '../../domain/services/category_service.dart';
import '../../domain/services/progress_engine.dart';

import '../widgets/overall_progress_card.dart';
import '../widgets/topic_progress_tile.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categoryService = CategoryService();
    final progressEngine = ProgressEngine();
    final readinessService = ReadinessService();

    final categories = categoryService.getCategoryStats();

    final readinessReport = readinessService.generateReport();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Text(
                'ALL TOPICS',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              OverallProgressCard(
                progress: progressEngine.overallAccuracy() / 100,

                answered: progressEngine.totalAnswered(),

                correct: progressEngine.totalCorrect(),

                incorrect: progressEngine.totalIncorrect(),

                accuracy: progressEngine.overallAccuracy(),

                averageTime: progressEngine.averageResponseTime(),

                readinessScore: readinessReport.readinessScore,

                confidenceLevel: readinessReport.confidenceLevel,

                strongestTopic: readinessReport.strongestTopic,

                weakestTopic: readinessReport.weakestTopic,
              ),

              const SizedBox(height: 12),

              Expanded(
                child: categories.isEmpty
                    ? Center(
                        child: Text(
                          'No progress data available yet.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),

                        itemCount: categories.length,

                        separatorBuilder: (context, _) =>
                            const SizedBox(height: 8),

                        itemBuilder: (context, index) {
                          final item = categories[index];

                          return TopicProgressTile(
                            category: item['category'] as String,

                            progress: (item['accuracy'] as num).toDouble(),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
