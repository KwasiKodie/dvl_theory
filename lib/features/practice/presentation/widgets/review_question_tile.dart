import 'package:flutter/material.dart';

class ReviewQuestionTile extends StatelessWidget {
  final int questionNumber;
  final bool isCorrect;
  final bool isFlagged;
  final VoidCallback onTap;

  const ReviewQuestionTile({
    super.key,
    required this.questionNumber,
    required this.isCorrect,
    required this.isFlagged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color color;
    IconData icon;
    String label;

    if (isFlagged) {
      color = Colors.orange;
      icon = Icons.flag;
      label = 'Flagged';
    } else if (isCorrect) {
      color = Colors.green;
      icon = Icons.check_circle;
      label = 'Correct';
    } else {
      color = Colors.red;
      icon = Icons.cancel;
      label = 'Wrong';
    }

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(.15),
          child: Text(
            '$questionNumber',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
