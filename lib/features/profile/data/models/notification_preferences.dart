class NotificationPreferences {
  final bool studyReminders;
  final bool testReminders;
  final bool newFeatures;
  final bool tipsAndAdvice;
  final bool promotions;

  const NotificationPreferences({
    required this.studyReminders,
    required this.testReminders,
    required this.newFeatures,
    required this.tipsAndAdvice,
    required this.promotions,
  });

  factory NotificationPreferences.defaults() {
    return const NotificationPreferences(
      studyReminders: true,
      testReminders: true,
      newFeatures: true,
      tipsAndAdvice: true,
      promotions: false,
    );
  }

  factory NotificationPreferences.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return NotificationPreferences.defaults();

    return NotificationPreferences(
      studyReminders: map['studyReminders'] ?? true,
      testReminders: map['testReminders'] ?? true,
      newFeatures: map['newFeatures'] ?? true,
      tipsAndAdvice: map['tipsAndAdvice'] ?? true,
      promotions: map['promotions'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studyReminders': studyReminders,
      'testReminders': testReminders,
      'newFeatures': newFeatures,
      'tipsAndAdvice': tipsAndAdvice,
      'promotions': promotions,
    };
  }

  NotificationPreferences copyWith({
    bool? studyReminders,
    bool? testReminders,
    bool? newFeatures,
    bool? tipsAndAdvice,
    bool? promotions,
  }) {
    return NotificationPreferences(
      studyReminders: studyReminders ?? this.studyReminders,
      testReminders: testReminders ?? this.testReminders,
      newFeatures: newFeatures ?? this.newFeatures,
      tipsAndAdvice: tipsAndAdvice ?? this.tipsAndAdvice,
      promotions: promotions ?? this.promotions,
    );
  }
}
