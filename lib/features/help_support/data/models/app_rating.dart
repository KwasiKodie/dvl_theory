class AppRating {
  final String id;
  final int stars;
  final String feedback;
  final String platform;
  final String appVersion;
  final DateTime? lastSyncAttempt;
  final bool uploaded;
  final int syncAttempts;

  const AppRating({
    required this.id,
    required this.stars,
    required this.feedback,
    required this.platform,
    required this.appVersion,
    this.lastSyncAttempt,
    this.uploaded = false,
    this.syncAttempts = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stars': stars,
      'feedback': feedback,
      'platform': platform,
      'appVersion': appVersion,
      'lastSyncAttempt': lastSyncAttempt?.toIso8601String(),
      'uploaded': uploaded,
      'syncAttempts': syncAttempts,
    };
  }

  factory AppRating.fromMap(Map<dynamic, dynamic> map) {
    return AppRating(
      id: map['id']?.toString() ?? '',
      stars: (map['stars'] as num?)?.toInt() ?? 0,
      feedback: map['feedback']?.toString() ?? '',
      platform: map['platform']?.toString() ?? '',
      appVersion: map['appVersion']?.toString() ?? '',
      uploaded: map['uploaded'] == true,
      syncAttempts: (map['syncAttempts'] as num?)?.toInt() ?? 0,
      lastSyncAttempt: map['lastSyncAttempt'] != null
          ? DateTime.tryParse(map['lastSyncAttempt'].toString())
          : null,
    );
  }

  AppRating copyWith({
    String? id,
    int? stars,
    String? feedback,
    String? platform,
    String? appVersion,
    DateTime? lastSyncAttempt,
    bool? uploaded,
    int? syncAttempts,
  }) {
    return AppRating(
      id: id ?? this.id,
      stars: stars ?? this.stars,
      feedback: feedback ?? this.feedback,
      platform: platform ?? this.platform,
      appVersion: appVersion ?? this.appVersion,
      lastSyncAttempt: lastSyncAttempt ?? this.lastSyncAttempt,
      uploaded: uploaded ?? this.uploaded,
      syncAttempts: syncAttempts ?? this.syncAttempts,
    );
  }
}
