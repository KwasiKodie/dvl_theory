import 'package:flutter/material.dart';

class MockInfoCard extends StatelessWidget {
  const MockInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green.withValues(alpha: 0.12),
            child: const Icon(Icons.timer_outlined, color: Colors.green),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Text(
              'The test is timed. The timer will start once you start.',
            ),
          ),
        ],
      ),
    );
  }
}
