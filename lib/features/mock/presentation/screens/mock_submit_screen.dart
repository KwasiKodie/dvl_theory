import 'package:flutter/material.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';

import '../../domain/services/mock_session_controller.dart';

class MockSubmitScreen extends StatelessWidget {
  const MockSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final session = MockSessionController.instance;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Mock Exam'),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 700
                ? 600.0
                : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.assignment_turned_in_outlined,
                          size: 62,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        'Are you sure you want to submit your test?',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'You won’t be able to change your answers after submitting.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 48),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: FilledButton(
                          onPressed: () {
                            session.submitted = true;
                            session.inProgress = false;

                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.mockResult,
                            );
                          },
                          child: const Text('Yes, Submit Test'),
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
