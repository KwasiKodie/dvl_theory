// ===========================
// home_theme.dart
// ===========================
import 'package:flutter/material.dart';

class HomeTheme {
  static const background = Color(0xFFF3F3F3);
  static const primary = Color(0xFF2979FF);

  static TextStyle headerGrey(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500);

  static TextStyle headerBold(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle cardTitle(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600);

  static TextStyle cardSubtitle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey[600]);
}
