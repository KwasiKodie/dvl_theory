import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/logout_tile.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../notifications/domain/services/notification_center_service.dart';
import '../../../notifications/presentation/widgets/notification_badge.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.background,
              surfaceTintColor: Colors.transparent,

              title: Text(
                'Profile',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AnimatedBuilder(
                    animation: NotificationCenterService.instance,
                    builder: (context, _) {
                      return NotificationBadge(
                        count: NotificationCenterService.instance.unreadCount,
                        child: IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.notificationCenter,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const ProfileHeader(),

                  const SizedBox(height: 24),

                  const ProfileStatsCard(),

                  SizedBox(height: 24),

                  ProfileMenuSection(),

                  SizedBox(height: 24),

                  LogoutTile(),

                  SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
