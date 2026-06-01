// ===========================
// scale_fade.dart
// ===========================
import 'package:flutter/material.dart';

class ScaleFade extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScaleFade({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<ScaleFade> createState() => _ScaleFadeState();
}

class _ScaleFadeState extends State<ScaleFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fade = curved;

    _scale = Tween<double>(begin: 0.8, end: 1).animate(curved);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
