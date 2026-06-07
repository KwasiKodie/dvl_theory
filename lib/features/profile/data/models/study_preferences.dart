enum QuestionMode { multipleChoice, mixed }

enum ExplanationMode { afterEveryAnswer, endOfTest, never }

class StudyPreferences {
  final QuestionMode questionMode;
  final int practiceQuestionCount;
  final bool practiceTimerEnabled;
  final ExplanationMode explanationMode;
  final bool saveWrongAnswers;
  final bool autoAdvance;
  final int mockDurationMinutes;
  final bool randomizeQuestions;
  final bool randomizeAnswers;

  const StudyPreferences({
    required this.questionMode,
    required this.practiceQuestionCount,
    required this.practiceTimerEnabled,
    required this.explanationMode,
    required this.saveWrongAnswers,
    required this.autoAdvance,
    required this.mockDurationMinutes,
    required this.randomizeQuestions,
    required this.randomizeAnswers,
  });

  factory StudyPreferences.defaults() {
    return const StudyPreferences(
      questionMode: QuestionMode.multipleChoice,
      practiceQuestionCount: 20,
      practiceTimerEnabled: true,
      explanationMode: ExplanationMode.afterEveryAnswer,
      saveWrongAnswers: true,
      autoAdvance: false,
      mockDurationMinutes: 30,
      randomizeQuestions: true,
      randomizeAnswers: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionMode': questionMode.name,
      'practiceQuestionCount': practiceQuestionCount,
      'practiceTimerEnabled': practiceTimerEnabled,
      'explanationMode': explanationMode.name,
      'saveWrongAnswers': saveWrongAnswers,
      'autoAdvance': autoAdvance,
      'mockDurationMinutes': mockDurationMinutes,
      'randomizeQuestions': randomizeQuestions,
      'randomizeAnswers': randomizeAnswers,
    };
  }

  factory StudyPreferences.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return StudyPreferences.defaults();

    return StudyPreferences(
      questionMode: QuestionMode.values.firstWhere(
        (e) => e.name == map['questionMode'],
        orElse: () => QuestionMode.multipleChoice,
      ),
      practiceQuestionCount: (map['practiceQuestionCount'] ?? 20) as int,
      practiceTimerEnabled: map['practiceTimerEnabled'] ?? true,
      explanationMode: ExplanationMode.values.firstWhere(
        (e) => e.name == map['explanationMode'],
        orElse: () => ExplanationMode.afterEveryAnswer,
      ),
      saveWrongAnswers: map['saveWrongAnswers'] ?? true,
      autoAdvance: map['autoAdvance'] ?? false,
      mockDurationMinutes: (map['mockDurationMinutes'] ?? 30) as int,
      randomizeQuestions: map['randomizeQuestions'] ?? true,
      randomizeAnswers: map['randomizeAnswers'] ?? false,
    );
  }

  StudyPreferences copyWith({
    QuestionMode? questionMode,
    int? practiceQuestionCount,
    bool? practiceTimerEnabled,
    ExplanationMode? explanationMode,
    bool? saveWrongAnswers,
    bool? autoAdvance,
    int? mockDurationMinutes,
    bool? randomizeQuestions,
    bool? randomizeAnswers,
  }) {
    return StudyPreferences(
      questionMode: questionMode ?? this.questionMode,
      practiceQuestionCount:
          practiceQuestionCount ?? this.practiceQuestionCount,
      practiceTimerEnabled: practiceTimerEnabled ?? this.practiceTimerEnabled,
      explanationMode: explanationMode ?? this.explanationMode,
      saveWrongAnswers: saveWrongAnswers ?? this.saveWrongAnswers,
      autoAdvance: autoAdvance ?? this.autoAdvance,
      mockDurationMinutes: mockDurationMinutes ?? this.mockDurationMinutes,
      randomizeQuestions: randomizeQuestions ?? this.randomizeQuestions,
      randomizeAnswers: randomizeAnswers ?? this.randomizeAnswers,
    );
  }
}
