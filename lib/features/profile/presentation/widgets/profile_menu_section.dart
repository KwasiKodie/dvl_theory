import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import 'profile_menu_tile.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProfileMenuTile(
            icon: Icons.people,
            title: 'Account',
            subtitle: 'Manage your personal information',

            onTap: () {
              Navigator.pushNamed(context, RouteNames.account);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.menu_book,
            title: 'Study Preferences',
            subtitle: 'Set your study and test preferences',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.studyPreferences);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage your notification settings',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.notifications);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.palette,
            title: 'Appearance',
            subtitle: 'Choose app theme',

            onTap: () {
              Navigator.pushNamed(context, RouteNames.settings);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Change app language',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.language);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.shield,
            title: 'Privacy & Security',
            subtitle: 'Manage your data privacy',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.privacySecurity);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and contact us',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.helpSupport);
            },
          ),

          const Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.about);
            },
          ),
        ],
      ),
    );
  }
}
