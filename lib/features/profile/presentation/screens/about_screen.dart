import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/about_branding_section.dart';
import '../widgets/about_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,

        title: Text(
          'About',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),

            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),

              child: Column(
                children: [
                  AboutBrandingSection(),
                  SizedBox(height: 28),
                  AboutCard(),
                  SizedBox(height: 32),
                  _CopyrightSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyrightSection extends StatelessWidget {
  const _CopyrightSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          '© 2025 DVLTHEORY. All rights reserved.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 32),

        Text(
          'Powered By',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          width: 90,
          height: 36,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),

          child: const Text(
            'VROTONIX',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
