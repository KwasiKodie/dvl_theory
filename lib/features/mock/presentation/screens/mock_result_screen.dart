import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../../domain/services/mock_session_controller.dart';

class MockResultScreen extends StatelessWidget {
  const MockResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final session = MockSessionController.instance;

    final passed = session.passed;

    final primaryColor = passed ? Colors.green : Colors.red;

    final title = passed ? 'Congratulations!' : 'Sorry';

    final subtitle = passed ? 'You Passed' : "You Didn't Pass";

    final score = session.correctCount;
    final total = session.totalQuestions;

    final percentage = session.scorePercent.round();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Results'),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 700
                ? 600.0
                : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                  child: Column(
                    children: [
                      _ResultHeader(
                        title: title,
                        subtitle: subtitle,
                        color: primaryColor,
                      ),

                      const SizedBox(height: 24),

                      _ScoreCard(
                        score: score,
                        total: total,
                        percentage: percentage,
                        color: primaryColor,
                      ),

                      const SizedBox(height: 20),

                      _StatisticsCard(
                        passMark: session.passingScore,
                        totalQuestions: session.totalQuestions,
                        correct: session.correctCount,
                        wrong: session.wrongCount,
                        color: primaryColor,
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.review,
                              arguments: session.buildReviewData(),
                            );
                          },
                          child: const Text('Review Answers'),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          onPressed: () {
                            session.reset();

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.home,
                              (route) => false,
                            );
                          },
                          child: const Text('Back Home'),
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

class _ResultHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const _ResultHeader({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final passed = subtitle.contains('Passed');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(.35)),
      ),
      child: Column(
        children: [
          Icon(
            passed ? Icons.emoji_events : Icons.sentiment_dissatisfied,
            color: color,
            size: 60,
          ),

          const SizedBox(height: 18),

          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            passed
                ? "Well done! You've achieved the passing score."
                : "Keep practicing and you'll get there next time!",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final int score;
  final int total;
  final int percentage;
  final Color color;

  const _ScoreCard({
    required this.score,
    required this.total,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = total == 0 ? 0.0 : score / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final ringSize = (constraints.maxWidth * 0.34).clamp(120.0, 170.0);
          final strokeWidth = (ringSize * 0.09).clamp(10.0, 16.0);

          return Center(
            child: SizedBox(
              width: ringSize,
              height: ringSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: strokeWidth,
                      backgroundColor: theme.colorScheme.outlineVariant,
                      color: color,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your Score',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$score / $total',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$percentage%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  final int passMark;
  final int totalQuestions;
  final int correct;
  final int wrong;
  final Color color;

  const _StatisticsCard({
    required this.passMark,
    required this.totalQuestions,
    required this.correct,
    required this.wrong,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _StatTile(
            icon: Icons.flag,
            label: 'Passing Score',
            value:
                '$passMark / $totalQuestions (${((passMark / totalQuestions) * 100).round()}%)',
            color: color,
            success: correct >= passMark,
          ),

          Divider(height: 1, color: theme.dividerColor),

          _StatTile(
            icon: Icons.check_circle,
            label: 'Correct Answers',
            value: '$correct',
            color: Colors.green,
            success: true,
          ),

          Divider(height: 1, color: theme.dividerColor),

          _StatTile(
            icon: Icons.cancel,
            label: 'Wrong Answers',
            value: '$wrong',
            color: Colors.red,
            success: false,
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool success;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: color),

          const SizedBox(width: 12),

          Expanded(child: Text(label, style: theme.textTheme.titleMedium)),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(width: 12),

              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  success ? Icons.check : Icons.close,
                  color: color,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
