import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../domain/services/social_links_service.dart';

class FollowUsScreen extends StatelessWidget {
  const FollowUsScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open link.')));
    }
  }

  IconData _iconFor(String name) {
    switch (name.toLowerCase()) {
      case 'website':
        return Icons.language;
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'tiktok':
        return Icons.music_note;
      case 'youtube':
        return Icons.play_circle_outline;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Follow Us'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: FutureBuilder<Map<String, String>>(
              future: SocialLinksService.instance.loadLinks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final links = snapshot.data!;

                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: links.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final name = links.keys.elementAt(index);
                    final url = links[name]!;

                    return Card(
                      elevation: 0,
                      child: ListTile(
                        leading: Icon(_iconFor(name)),
                        title: Text(name),
                        subtitle: Text(url),
                        trailing: const Icon(Icons.open_in_new),
                        onTap: () => _openLink(context, url),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
