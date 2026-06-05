import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../../domain/services/mock_session_controller.dart';

class MockSummaryScreen extends StatelessWidget {
  const MockSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final session = MockSessionController.instance;

    final answered = session.answeredCount;
    final flagged = session.flaggedCount;
    final unanswered = session.unansweredCount;

    final remaining = session.remainingTime;

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;

    final timeString =
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        title: const Text('Mock Exam'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TimerCard(timeString: timeString),

              const SizedBox(height: 22),

              _CompletionCard(
                answered: answered,
                total: session.totalQuestions,
              ),

              const SizedBox(height: 22),

              _StatisticsCard(
                answered: answered,
                total: session.totalQuestions,
                flagged: flagged,
                unanswered: unanswered,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
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
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.mockSubmit);
                  },
                  child: const Text('Submit Test'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerCard extends StatelessWidget {
  final String timeString;

  const _TimerCard({required this.timeString});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color color = Colors.green;

    if (timeString.startsWith('00:')) {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: color.withOpacity(.10),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: color.withOpacity(.35)),
      ),

      child: Row(
        children: [
          Icon(Icons.timer_outlined, color: color, size: 42),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Time left', style: theme.textTheme.bodyMedium),

                Text(
                  timeString,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionCard extends StatelessWidget {
  final int answered;
  final int total;

  const _CompletionCard({required this.answered, required this.total});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        children: [
          Icon(Icons.hourglass_top, size: 40, color: theme.colorScheme.primary),

          const SizedBox(height: 10),

          Text(
            answered >= total
                ? 'You have answered all questions!'
                : 'Review before submitting',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Please review your answers before submitting.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  final int answered;
  final int total;
  final int flagged;
  final int unanswered;

  const _StatisticsCard({
    required this.answered,
    required this.total,
    required this.flagged,
    required this.unanswered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: theme.dividerColor),
      ),

      child: Column(
        children: [
          _StatRow(
            icon: Icons.check_circle,
            label: 'Answered',
            value: '$answered / $total',
            color: Colors.green,
          ),

          Divider(height: 1, color: theme.dividerColor),

          _StatRow(
            icon: Icons.flag,
            label: 'Flagged for review',
            value: '$flagged',
            color: Colors.orange,
          ),

          Divider(height: 1, color: theme.dividerColor),

          _StatRow(
            icon: Icons.cancel,
            label: 'Unanswered',
            value: '$unanswered',
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
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

          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
