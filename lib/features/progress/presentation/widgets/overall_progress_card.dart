import 'package:flutter/material.dart';

class OverallProgressCard extends StatelessWidget {
  final double progress;
  final int answered;
  final int correct;
  final int incorrect;

  final double accuracy;
  final double averageTime;
  final double readinessScore;
  final String confidenceLevel;
  final String strongestTopic;
  final String weakestTopic;

  const OverallProgressCard({
    super.key,
    required this.progress,
    required this.answered,
    required this.correct,
    required this.incorrect,
    required this.accuracy,
    required this.averageTime,
    required this.readinessScore,
    required this.confidenceLevel,
    required this.strongestTopic,
    required this.weakestTopic,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return Container(
          padding: EdgeInsets.all(isTablet ? 20 : 16),

          decoration: BoxDecoration(
            color: theme.colorScheme.surface,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: theme.dividerColor.withOpacity(.15)),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? .15 : .04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Overall Progress',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.12),

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      '${accuracy.round()}%',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              LinearProgressIndicator(
                value: progress,
                minHeight: 8,

                borderRadius: BorderRadius.circular(20),

                backgroundColor: theme.colorScheme.primary.withOpacity(.12),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _metric(context, "Accuracy", "${accuracy.round()}%"),
                  ),

                  Expanded(child: _metric(context, "Answered", "$answered")),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _metric(
                      context,
                      "Avg Time",
                      "${averageTime.round()} sec",
                    ),
                  ),

                  Expanded(
                    child: _metric(context, "Confidence", confidenceLevel),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _metric(BuildContext context, String label, String value) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: theme.textTheme.bodySmall),

      const SizedBox(height: 2),

      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
