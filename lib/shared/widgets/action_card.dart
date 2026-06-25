import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class HomeActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallPhone = Responsive.isSmallPhone(context);
        final isTablet = Responsive.isTablet(context);

        final horizontalPadding = isTablet ? 24.0 : 18.0;
        final verticalPadding = isTablet ? 22.0 : 16.0;

        final iconSize = isTablet
            ? 34.0
            : isSmallPhone
            ? 20.0
            : 26.0;

        final avatarRadius = isTablet
            ? 32.0
            : isSmallPhone
            ? 22.0
            : 26.0;

        final titleSize = isTablet
            ? 20.0
            : isSmallPhone
            ? 14.0
            : 16.0;

        final subtitleSize = isTablet
            ? 15.0
            : isSmallPhone
            ? 11.0
            : 13.0;

        return Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.015),
          child: Material(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            elevation: theme.brightness == Brightness.dark ? 0 : 1.5,
            shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      height: avatarRadius * 2,
                      width: avatarRadius * 2,
                      decoration: BoxDecoration(
                        color: color.withValues(
                          alpha: theme.brightness == Brightness.dark
                              ? 0.20
                              : 0.12,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: iconSize),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.004),
                          Text(
                            subtitle,
                            maxLines: isTablet ? 2 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: subtitleSize,
                              height: 1.4,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.65,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.35,
                      ),
                      size: isTablet ? 30 : 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
