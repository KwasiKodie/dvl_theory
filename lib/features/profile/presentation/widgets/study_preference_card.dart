import 'package:flutter/material.dart';

import '../../data/models/study_preferences.dart';
import '../../domain/services/study_preferences_controller.dart';
import 'study_preference_tile.dart';

class StudyPreferenceCard extends StatelessWidget {
  const StudyPreferenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StudyPreferencesController.instance;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final preferences = controller.preferences;

        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withOpacity(0.6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                StudyPreferenceTile(
                  title: 'Default Question Mode',
                  value: _questionModeLabel(preferences.questionMode),
                  onTap: () => _showQuestionModePicker(context),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Question per Practice Test',
                  value: '${preferences.practiceQuestionCount} Questions',
                  onTap: () => _showQuestionCountPicker(context),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Timer for Practice Test',
                  trailing: Switch(
                    value: preferences.practiceTimerEnabled,
                    onChanged: controller.setPracticeTimerEnabled,
                  ),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Show Explanations',
                  value: _explanationModeLabel(preferences.explanationMode),
                  onTap: () => _showExplanationModePicker(context),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Save Wrong Answers',
                  trailing: Switch(
                    value: preferences.saveWrongAnswers,
                    onChanged: controller.setSaveWrongAnswers,
                  ),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Auto Advance to Next Question',
                  value: preferences.autoAdvance ? 'Enabled' : 'Disabled',
                  valueMuted: !preferences.autoAdvance,
                  trailing: Switch(
                    value: preferences.autoAdvance,
                    onChanged: controller.setAutoAdvance,
                  ),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Default Mock Test Time',
                  value: '${preferences.mockDurationMinutes} Minutes',
                  onTap: () => _showMockTimePicker(context),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Randomize Questions',
                  trailing: Switch(
                    value: preferences.randomizeQuestions,
                    onChanged: controller.setRandomizeQuestions,
                  ),
                ),
                const _PreferenceDivider(),

                StudyPreferenceTile(
                  title: 'Randomize Answers',
                  trailing: Switch(
                    value: preferences.randomizeAnswers,
                    onChanged: controller.setRandomizeAnswers,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _questionModeLabel(QuestionMode mode) {
    return switch (mode) {
      QuestionMode.multipleChoice => 'Multiple Choice',
      QuestionMode.mixed => 'Mixed',
    };
  }

  String _explanationModeLabel(ExplanationMode mode) {
    return switch (mode) {
      ExplanationMode.afterEveryAnswer => 'After Every Answer',
      ExplanationMode.endOfTest => 'End Of Test',
      ExplanationMode.never => 'Never',
    };
  }

  Future<void> _showQuestionModePicker(BuildContext context) async {
    final controller = StudyPreferencesController.instance;

    final selected = await showModalBottomSheet<QuestionMode>(
      context: context,
      showDragHandle: true,
      builder: (_) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<QuestionMode>(
                value: QuestionMode.multipleChoice,
                groupValue: controller.preferences.questionMode,
                title: const Text('Multiple Choice'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<QuestionMode>(
                value: QuestionMode.mixed,
                groupValue: controller.preferences.questionMode,
                title: const Text('Mixed'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );

    if (selected != null) {
      await controller.setQuestionMode(selected);
    }
  }

  Future<void> _showQuestionCountPicker(BuildContext context) async {
    final selected = await _showNumberPicker(
      context: context,
      title: 'Questions per Practice Test',
      values: const [10, 20, 30, 50],
      suffix: 'Questions',
      current:
          StudyPreferencesController.instance.preferences.practiceQuestionCount,
    );

    if (selected != null) {
      await StudyPreferencesController.instance.setPracticeQuestionCount(
        selected,
      );
    }
  }

  Future<void> _showMockTimePicker(BuildContext context) async {
    final selected = await _showNumberPicker(
      context: context,
      title: 'Default Mock Test Time',
      values: const [15, 20, 30, 45, 60],
      suffix: 'Minutes',
      current:
          StudyPreferencesController.instance.preferences.mockDurationMinutes,
    );

    if (selected != null) {
      await StudyPreferencesController.instance.setMockDurationMinutes(
        selected,
      );
    }
  }

  Future<void> _showExplanationModePicker(BuildContext context) async {
    final controller = StudyPreferencesController.instance;

    final selected = await showModalBottomSheet<ExplanationMode>(
      context: context,
      showDragHandle: true,
      builder: (_) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ExplanationMode>(
                value: ExplanationMode.afterEveryAnswer,
                groupValue: controller.preferences.explanationMode,
                title: const Text('After Every Answer'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<ExplanationMode>(
                value: ExplanationMode.endOfTest,
                groupValue: controller.preferences.explanationMode,
                title: const Text('End Of Test'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<ExplanationMode>(
                value: ExplanationMode.never,
                groupValue: controller.preferences.explanationMode,
                title: const Text('Never'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );

    if (selected != null) {
      await controller.setExplanationMode(selected);
    }
  }

  Future<int?> _showNumberPicker({
    required BuildContext context,
    required String title,
    required List<int> values,
    required String suffix,
    required int current,
  }) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) {
        final maxHeight = MediaQuery.of(context).size.height * 0.75;

        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                ...values.map(
                  (value) => RadioListTile<int>(
                    value: value,
                    groupValue: current,
                    title: Text('$value $suffix'),
                    onChanged: (value) => Navigator.pop(context, value),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PreferenceDivider extends StatelessWidget {
  const _PreferenceDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
