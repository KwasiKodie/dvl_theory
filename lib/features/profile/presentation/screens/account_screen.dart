import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../widgets/account_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.background,

        title: Text(
          'Account',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 700 : width),

            child: const SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: AccountCard(),
            ),
          ),
        ),
      ),
    );
  }
}
