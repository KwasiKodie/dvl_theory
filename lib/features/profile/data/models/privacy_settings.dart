class PrivacySettings {
  final bool analyticsEnabled;
  final bool personalizedAds;
  final bool crashReporting;

  const PrivacySettings({
    required this.analyticsEnabled,
    required this.personalizedAds,
    required this.crashReporting,
  });

  factory PrivacySettings.defaults() {
    return const PrivacySettings(
      analyticsEnabled: true,
      personalizedAds: false,
      crashReporting: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'analyticsEnabled': analyticsEnabled,
      'personalizedAds': personalizedAds,
      'crashReporting': crashReporting,
    };
  }

  factory PrivacySettings.fromMap(Map map) {
    return PrivacySettings(
      analyticsEnabled: map['analyticsEnabled'] ?? true,
      personalizedAds: map['personalizedAds'] ?? false,
      crashReporting: map['crashReporting'] ?? true,
    );
  }

  PrivacySettings copyWith({
    bool? analyticsEnabled,
    bool? personalizedAds,
    bool? crashReporting,
  }) {
    return PrivacySettings(
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      personalizedAds: personalizedAds ?? this.personalizedAds,
      crashReporting: crashReporting ?? this.crashReporting,
    );
  }
}