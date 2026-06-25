// ===========================
// splash_screen.dart
// ===========================
import 'package:flutter/material.dart';
import '../widgets/splash_branding_section.dart';
import '../widgets/splash_bottom_text.dart';
import '../../../../core/constants/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            final isSmallHeight = height < 650;
            final isLandscape = width > height;

            return Stack(
              fit: StackFit.expand,
              children: [
                Semantics(
                  label: 'Driving theory app splash background',
                  image: true,
                  child: Image.asset(
                    AppAssets.splashBackground,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: isSmallHeight ? 8 : 16,
                  ),
                  child: isLandscape
                      ? const _LandscapeSplashLayout()
                      : const _PortraitSplashLayout(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PortraitSplashLayout extends StatelessWidget {
  const _PortraitSplashLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Flexible(flex: 4, child: SplashBrandingSection()),
        Spacer(flex: 3),
        Flexible(flex: 3, child: SplashBottomText()),
      ],
    );
  }
}

class _LandscapeSplashLayout extends StatelessWidget {
  const _LandscapeSplashLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: SplashBrandingSection()),
        Expanded(child: SplashBottomText()),
      ],
    );
  }
}
