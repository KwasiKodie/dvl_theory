import 'package:flutter/material.dart';

class ReviewStatusBadge extends StatelessWidget {
  final bool isCorrect;
  final bool isFlagged;

  const ReviewStatusBadge({
    super.key,
    required this.isCorrect,
    required this.isFlagged,
  });

  @override
  Widget build(BuildContext context) {
    final status = _status();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 15, color: status.color),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: TextStyle(
              color: status.color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  _ReviewStatus _status() {
    if (isFlagged) {
      return const _ReviewStatus(
        label: 'Flagged',
        icon: Icons.flag,
        color: Colors.orange,
      );
    }

    if (isCorrect) {
      return const _ReviewStatus(
        label: 'Correct',
        icon: Icons.flag,
        color: Colors.green,
      );
    }

    return const _ReviewStatus(
      label: 'Wrong',
      icon: Icons.flag,
      color: Colors.red,
    );
  }
}

class _ReviewStatus {
  final String label;
  final IconData icon;
  final Color color;

  const _ReviewStatus({
    required this.label,
    required this.icon,
    required this.color,
  });
}
