// ===========================
// route_transitions.dart
// ===========================
import 'package:flutter/material.dart';

import '../../shared/animations/route_animations.dart';

class RouteTransitions {
  const RouteTransitions._();

  static Route fadeSlide(Widget page) {
    return RouteAnimations.fadeSlide(page);
  }

  static Route fade(Widget page) {
    return RouteAnimations.fade(page);
  }
}
