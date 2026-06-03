import 'package:flutter/material.dart';

class PracticeAnswerOptionTile extends StatelessWidget {
  final String optionKey;
  final String optionText;
  final String? selectedAnswer;
  final String correctAnswer;
  final bool showResult;
  final VoidCallback onTap;

  const PracticeAnswerOptionTile({
    super.key,
    required this.optionKey,
    required this.optionText,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.showResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selected = selectedAnswer == optionKey;
    final correct = correctAnswer == optionKey;

    Color border = theme.colorScheme.outlineVariant;
    Color background = theme.colorScheme.surface;
    Color badge = theme.colorScheme.onSurfaceVariant;
    Color badgeText = theme.colorScheme.surface;

    if (showResult && correct) {
      border = Colors.green;
      background = Colors.green.withOpacity(0.14);
      badge = Colors.green;
      badgeText = Colors.white;
    } else if (showResult && selected) {
      border = theme.colorScheme.error;
      background = theme.colorScheme.error.withOpacity(0.12);
      badge = theme.colorScheme.error;
      badgeText = theme.colorScheme.onError;
    } else if (selected) {
      border = theme.colorScheme.primary;
      background = theme.colorScheme.primary.withOpacity(0.08);
      badge = theme.colorScheme.primary;
      badgeText = theme.colorScheme.onPrimary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: showResult ? null : onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: badge,
                  child: Text(
                    optionKey.toUpperCase(),
                    style: TextStyle(
                      color: badgeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    optionText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selected && showResult && correct
                          ? Colors.green.shade800
                          : theme.colorScheme.onSurface,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
