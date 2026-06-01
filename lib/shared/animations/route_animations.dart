// ===========================
// route_animations.dart
// ===========================
import 'package:flutter/material.dart';

class RouteAnimations {
  static Route fadeSlide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),

      pageBuilder: (_, animation, __) => page,

      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,

          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(animation),

            child: child,
          ),
        );
      },
    );
  }

  static Route fade(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),

      pageBuilder: (_, animation, __) => page,

      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
