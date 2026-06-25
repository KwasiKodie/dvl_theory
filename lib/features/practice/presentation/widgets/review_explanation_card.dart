import 'package:flutter/material.dart';

class ReviewExplanationCard extends StatelessWidget {
  final String explanation;
  final String? imagePath;
  final bool isCorrect;
  final bool isFlagged;

  const ReviewExplanationCard({
    super.key,
    required this.explanation,
    required this.isCorrect,
    required this.isFlagged,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = isFlagged
        ? Colors.orange
        : isCorrect
        ? Colors.green
        : Colors.red;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.75)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explanation',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  explanation,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          if (imagePath != null) ...[
            const SizedBox(width: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                imagePath!,
                width: 108,
                height: 102,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
