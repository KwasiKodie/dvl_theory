import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String code;
  final String nativeName;
  final String englishName;
  final bool selected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Radio<String>(value: code),

            Expanded(
              child: Text(
                nativeName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Text(
              englishName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
