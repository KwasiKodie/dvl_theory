// ===========================
// splash_theme.dart
// ===========================
import 'package:flutter/material.dart';

class SplashTheme {
  static const backgroundColor = Color(0xFFF3F3F3);

  static TextStyle titleBlack(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: -0.5,
      );

  static TextStyle titleRed(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 242, 26, 10),
        letterSpacing: -0.5,
      );

  static TextStyle tagline(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: const Color.fromARGB(255, 61, 59, 59),
        fontWeight: FontWeight.w500,
      );

  static TextStyle headline(BuildContext context) => Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle subtext(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: Colors.grey[700], height: 1.4);
}
