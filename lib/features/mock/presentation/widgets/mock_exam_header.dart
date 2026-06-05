import 'package:flutter/material.dart';

class MockExamHeader extends StatelessWidget {
  const MockExamHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.green,
          child: Icon(Icons.school, size: 40, color: Colors.white),
        ),

        const SizedBox(height: 18),

        Text(
          'Real exam simulation\nwith 20 random questions',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
