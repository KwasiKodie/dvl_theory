import 'package:flutter/material.dart';

class InstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InstructionItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 30, color: theme.colorScheme.onSurfaceVariant),

          const SizedBox(width: 22),

          Expanded(
            child: Text(
              text,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
