// ===========================
// staggered_fade_slide.dart
// ===========================
import 'package:flutter/material.dart';

class StaggeredFadeSlide extends StatefulWidget {
  final Widget child;
  final int delay;

  const StaggeredFadeSlide({super.key, required this.child, this.delay = 0});

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fade;

  late Animation<Offset> _slide;

  // ===========================
  // INIT
  // ===========================
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_fade);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  // ===========================
  // CLEANUP
  // ===========================
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // ===========================
  // BUILD
  // ===========================
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,

      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
