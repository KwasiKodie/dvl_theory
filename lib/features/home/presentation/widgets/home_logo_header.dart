import 'package:flutter/material.dart';

class HomeLogoHeader extends StatelessWidget {
  const HomeLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Image.asset(
          'assets/images/shared/logo.png',
          width: 48,
          height: 48,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
            children: [
              TextSpan(
                text: 'DVL',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              const TextSpan(
                text: 'THEORY',
                style: TextStyle(color: Color.fromRGBO(249, 52, 26, 0.965)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
