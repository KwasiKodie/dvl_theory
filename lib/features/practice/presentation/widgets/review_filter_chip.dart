import 'package:flutter/material.dart';

class ReviewFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const ReviewFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: color.withValues(alpha: 0.12),
      selectedColor: color,
      side: BorderSide.none,
      showCheckmark: false,
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
