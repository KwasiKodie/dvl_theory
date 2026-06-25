import 'package:flutter/material.dart';

class AboutBrandingSection extends StatelessWidget {
  const AboutBrandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Image.asset('assets/images/shared/logo.png', width: 140),

        const SizedBox(height: 16),

        RichText(
          text: TextSpan(
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),

            children: [
              TextSpan(
                text: 'DVL',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),

              const TextSpan(
                text: 'THEORY',
                style: TextStyle(color: Color(0xFFFF1A0A)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Version 1.0.0',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
