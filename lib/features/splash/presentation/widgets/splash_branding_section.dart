// ===========================
// splash_branding_section.dart
// ===========================
import 'package:flutter/material.dart';
import '../../../../shared/animations/fade_slide.dart';
import 'splash_theme.dart';
import '../../../../core/constants/app_assets.dart';

class SplashBrandingSection extends StatelessWidget {
  const SplashBrandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final logoSize = (width * 0.32).clamp(72.0, 150.0);
        final compact = height < 220;

        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeSlide(
                  child: Semantics(
                    label: 'DVL Theory logo',
                    image: true,
                    child: Image.asset(
                      AppAssets.sharedLogo,
                      width: logoSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: compact ? 6 : 10),

                FadeSlide(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'DVL',
                          style: SplashTheme.titleBlack(context),
                        ),
                        TextSpan(
                          text: 'THEORY',
                          style: SplashTheme.titleRed(context),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: compact ? 3 : 6),

                FadeSlide(
                  child: Text(
                    'Learn. Practice. Pass.',
                    textAlign: TextAlign.center,
                    style: SplashTheme.tagline(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
