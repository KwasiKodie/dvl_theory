import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../domain/services/support_service.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  final _feedbackController = TextEditingController();

  int _stars = 5;
  bool _saving = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _saving = true);

    await SupportService.instance.submitRating(
      stars: _stars,
      feedback: _feedbackController.text,
    );

    if (!mounted) return;

    setState(() => _saving = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Thanks for your feedback.')));

    Navigator.pop(context);
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
        title: const Text('Rate Our App'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 720 : width),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'How was your experience?',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 4,
                        children: List.generate(5, (index) {
                          final value = index + 1;
                          return IconButton(
                            onPressed: () {
                              setState(() => _stars = value);
                            },
                            icon: Icon(
                              value <= _stars ? Icons.star : Icons.star_border,
                              size: 34,
                              color: Colors.amber,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _feedbackController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Feedback (optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: _saving ? null : _submit,
                          child: _saving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Submit Feedback'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
