import 'package:flutter/material.dart';

import 'study_preference_tile.dart';

class StudyPreferenceCard extends StatefulWidget {
  const StudyPreferenceCard({super.key});

  @override
  State<StudyPreferenceCard> createState() => _StudyPreferenceCardState();
}

class _StudyPreferenceCardState extends State<StudyPreferenceCard> {
  bool timerEnabled = true;
  bool saveWrongAnswers = true;
  bool autoAdvance = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            StudyPreferenceTile(
              title: 'Default Question Mode',
              value: 'Multiple Choice',
              onTap: () {},
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Question per Practice Test',
              value: '20 Questions',
              onTap: () {},
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Timer for Practice Test',
              trailing: Switch(
                value: timerEnabled,
                onChanged: (value) {
                  setState(() => timerEnabled = value);
                },
              ),
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Show Explanations',
              value: 'After Every Answer',
              onTap: () {},
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Save Wrong Answers',
              trailing: Switch(
                value: saveWrongAnswers,
                onChanged: (value) {
                  setState(() => saveWrongAnswers = value);
                },
              ),
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Auto Advance to Next Question',
              value: autoAdvance ? 'Enabled' : 'Disabled',
              valueMuted: !autoAdvance,
              trailing: Switch(
                value: autoAdvance,
                onChanged: (value) {
                  setState(() => autoAdvance = value);
                },
              ),
            ),
            const _PreferenceDivider(),

            StudyPreferenceTile(
              title: 'Default Mock Test Time',
              value: '30 Minutes',
              onTap: () {},
            ),
          ],
        ),
      ),
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
