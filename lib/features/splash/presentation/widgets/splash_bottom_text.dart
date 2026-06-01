import 'package:flutter/material.dart';

import '../../../../shared/animations/fade_slide.dart';
import 'splash_theme.dart';

class SplashBottomText extends StatelessWidget {
  const SplashBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 180;

        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeSlide(
                  child: Text(
                    'Your Road to Success',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SplashTheme.headline(context),
                  ),
                ),

                SizedBox(height: compact ? 4 : 8),

                FadeSlide(
                  child: Text(
                    'Everything you need to pass\nyour driving theory test.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: SplashTheme.subtext(context),
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
