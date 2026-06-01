import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import 'splash_screen.dart';

class SplashScreenController extends StatefulWidget {
  const SplashScreenController({super.key});

  @override
  State<SplashScreenController> createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
