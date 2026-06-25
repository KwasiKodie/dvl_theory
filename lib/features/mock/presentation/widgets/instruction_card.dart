import 'package:flutter/material.dart';

import 'instruction_item.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.withValues(alpha: 0.35)),
      ),
      child: const Column(
        children: [
          InstructionItem(
            icon: Icons.assignment_outlined,
            text: '20 random questions',
          ),

          InstructionItem(
            icon: Icons.timer_outlined,
            text: '30 minutes total time',
          ),

          InstructionItem(
            icon: Icons.done,
            text: '1 mark for each correct answer',
          ),

          InstructionItem(
            icon: Icons.looks_4_outlined,
            text: 'You need 15 or more to pass (70%)',
          ),

          InstructionItem(
            icon: Icons.timer_off_outlined,
            text: 'You can’t pause the timer',
          ),

          InstructionItem(
            icon: Icons.check_circle_outline,
            text: 'Answer all questions',
          ),
        ],
      ),
    );
  }
}
