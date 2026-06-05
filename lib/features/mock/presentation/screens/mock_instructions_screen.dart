import 'package:flutter/material.dart';

import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../widgets/instruction_card.dart';
import '../../../../core/navigation/route_names.dart';

class MockInstructionsScreen extends StatelessWidget {
  const MockInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Instructions'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 700
                ? 600.0
                : constraints.maxWidth;

            return Center(
              child: SizedBox(
                width: maxWidth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
                  child: Column(
                    children: [
                      const InstructionCard(),

                      const SizedBox(height: 42),

                      Text(
                        'Make sure you are ready before\nyou start the test.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 42),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.mockExam,
                            );
                          },
                          child: const Text("I'm Ready, Start Test"),
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
