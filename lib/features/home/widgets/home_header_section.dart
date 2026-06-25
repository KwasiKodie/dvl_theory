import 'package:flutter/material.dart';
import '../../../shared/animations/staggered_fade_slide.dart';
import '../../../../core/utils/responsive.dart';

class HomeHeaderSection extends StatelessWidget {
  final String userName;
  final String logoPath;

  const HomeHeaderSection({
    super.key,
    this.userName = 'Learner',
    this.logoPath = 'assets/images/shared/logo.png',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = media.size.width;
        final height = media.size.height;

        final isSmallPhone = Responsive.isSmallPhone(context);
        final isTablet = Responsive.isTablet(context);
        final isLandscape = width > height;

        final horizontalPadding = isTablet ? width * 0.08 : width * 0.045;

        final logoWidth = isTablet
            ? width * 0.18
            : isLandscape
            ? width * 0.16
            : width * 0.28;

        final titleSize = isTablet
            ? 32.0
            : isSmallPhone
            ? 20.0
            : 24.0;

        final subtitleSize = isTablet
            ? 18.0
            : isSmallPhone
            ? 13.0
            : 15.0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: StaggeredFadeSlide(
                  delay: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, $userName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: subtitleSize,
                          color: theme.colorScheme.surface.withValues(
                            alpha: 0.65,
                          ),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Let’s get you',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.surface,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        'test ready!',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.surface,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Flexible(
                flex: 3,
                child: StaggeredFadeSlide(
                  delay: 250,
                  child: Semantics(
                    label: 'DVL Theory app logo',
                    image: true,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: logoWidth,
                        maxHeight: isTablet ? 160 : 110,
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Image.asset(logoPath, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
