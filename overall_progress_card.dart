import 'package:flutter/material.dart';

Widget _buildOverallCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(value: 0.72, strokeWidth: 6),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Overall Progress"),
            Text("193 / 270 questions"),
          ],
        ),
      ],
    ),
  );
}
