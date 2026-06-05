import 'package:flutter/material.dart';

class ReviewOptionTile extends StatelessWidget {
  final String optionKey;
  final String optionText;
  final String? selectedAnswer;
  final String correctAnswer;
  final bool isFlagged;

  const ReviewOptionTile({
    super.key,
    required this.optionKey,
    required this.optionText,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isFlagged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isSelected = selectedAnswer == optionKey;
    final isCorrectAnswer = correctAnswer == optionKey;
    final selectedWrong = isSelected && !isCorrectAnswer;

    final Color activeColor = isFlagged
        ? Colors.orange
        : isCorrectAnswer
        ? Colors.green
        : selectedWrong
        ? Colors.red
        : theme.colorScheme.outline;

    final bool highlighted = isSelected || isCorrectAnswer;

    final background = highlighted
        ? activeColor.withOpacity(.13)
        : theme.colorScheme.surface;

    final border = highlighted ? activeColor : theme.colorScheme.outlineVariant;

    final badgeBackground = highlighted
        ? activeColor.withOpacity(.18)
        : theme.colorScheme.surfaceContainerHighest;

    final badgeTextColor = highlighted
        ? activeColor
        : theme.colorScheme.onSurfaceVariant;

    IconData? trailingIcon;

    if (isCorrectAnswer) {
      trailingIcon = Icons.check;
    } else if (selectedWrong) {
      trailingIcon = Icons.close;
    } else if (isFlagged && isSelected) {
      trailingIcon = Icons.flag;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: badgeBackground,
                child: Text(
                  optionKey.toUpperCase(),
                  style: TextStyle(
                    color: badgeTextColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  optionText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: highlighted ? FontWeight.w600 : FontWeight.w400,
                    color: highlighted
                        ? activeColor
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, color: activeColor, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
