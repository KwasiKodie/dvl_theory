import 'package:flutter/material.dart';

import '../../../../core/storage/cache_service.dart';
import '../../domain/services/export_service.dart';
import '../../domain/services/privacy_controller.dart';
import 'privacy_security_tile.dart';

class PrivacySecurityCard extends StatefulWidget {
  const PrivacySecurityCard({super.key});

  @override
  State<PrivacySecurityCard> createState() => _PrivacySecurityCardState();
}

class _PrivacySecurityCardState extends State<PrivacySecurityCard> {
  bool _isExporting = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            /// 🔹 DATA USAGE
            GestureDetector(
              onTap: () {
                setState(() => _isExpanded = !_isExpanded);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.storage, color: theme.colorScheme.onSurface),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Text(
                            'Data Usage',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.expand_more),
                        ),
                      ],
                    ),

                    /// 🔽 EXPANDABLE CONTENT
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      firstChild: const SizedBox(),

                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: AnimatedBuilder(
                          animation: PrivacyController.instance,
                          builder: (_, _) {
                            final settings =
                                PrivacyController.instance.settings;

                            return Column(
                              children: [
                                SwitchListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Analytics'),
                                  value: settings.analyticsEnabled,
                                  onChanged:
                                      PrivacyController.instance.setAnalytics,
                                ),

                                SwitchListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Personalized Ads'),
                                  value: settings.personalizedAds,
                                  onChanged: PrivacyController.instance.setAds,
                                ),

                                SwitchListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Crash Reporting'),
                                  value: settings.crashReporting,
                                  onChanged: PrivacyController
                                      .instance
                                      .setCrashReporting,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const _PrivacyDivider(),

            /// 🔹 CLEAR CACHE
            PrivacySecurityTile(
              icon: Icons.cleaning_services,
              title: 'Clear Cache',
              subtitle: 'Free up storage space',
              valueWidget: FutureBuilder<double>(
                future: CacheService.getCacheSizeMB(),
                builder: (_, snapshot) {
                  final size = snapshot.data ?? 0;
                  return Text('${size.toStringAsFixed(1)} MB');
                },
              ),
              onTap: () => _confirmClearCache(context),
            ),

            const _PrivacyDivider(),

            /// 🔹 EXPORT DATA (WITH LOADING)
            PrivacySecurityTile(
              icon: Icons.file_download_outlined,
              title: 'Export My Data',
              subtitle: 'Download your data',
              valueWidget: _isExporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              onTap: _isExporting ? null : _handleExport,
            ),

            const _PrivacyDivider(),

            /// 🔹 DELETE ACCOUNT
            PrivacySecurityTile(
              icon: Icons.delete,
              title: 'Delete Account',
              subtitle: 'Permanently delete your account',
              destructive: true,
              onTap: () => _showDeleteDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // 🔁 EXPORT HANDLER
  // =====================================================
  Future<void> _handleExport() async {
    setState(() => _isExporting = true);

    try {
      final path = await ExportService.exportUserData();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data exported to $path')));
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Export failed')));
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  // =====================================================
  // 🧹 CLEAR CACHE CONFIRMATION
  // =====================================================
  Future<void> _confirmClearCache(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove temporary files and free storage space. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await CacheService.clearCache();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Cache cleared')));

    setState(() {}); // refresh cache size
  }

  // =====================================================
  // 🗑 DELETE ACCOUNT
  // =====================================================
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to permanently delete your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _PrivacyDivider extends StatelessWidget {
  const _PrivacyDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
