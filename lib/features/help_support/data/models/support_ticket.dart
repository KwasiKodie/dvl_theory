class SupportTicket {
  final String id;
  final String category;
  final String description;
  final String platform;
  final String appVersion;
  final DateTime? lastSyncAttempt;
  final bool uploaded;
  final int syncAttempts;

  const SupportTicket({
    required this.id,
    required this.category,
    required this.description,
    required this.platform,
    required this.appVersion,
    this.lastSyncAttempt,
    this.uploaded = false,
    this.syncAttempts = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'platform': platform,
      'appVersion': appVersion,
      'lastSyncAttempt': lastSyncAttempt?.toIso8601String(),
      'uploaded': uploaded,
      'syncAttempts': syncAttempts,
    };
  }

  factory SupportTicket.fromMap(Map<dynamic, dynamic> map) {
    return SupportTicket(
      id: map['id']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      platform: map['platform']?.toString() ?? '',
      appVersion: map['appVersion']?.toString() ?? '',
      uploaded: map['uploaded'] == true,
      syncAttempts: (map['syncAttempts'] as num?)?.toInt() ?? 0,
      lastSyncAttempt: map['lastSyncAttempt'] != null
          ? DateTime.tryParse(map['lastSyncAttempt'].toString())
          : null,
    );
  }

  SupportTicket copyWith({
    String? id,
    String? category,
    String? description,
    String? platform,
    String? appVersion,
    DateTime? lastSyncAttempt,
    bool? uploaded,
    int? syncAttempts,
  }) {
    return SupportTicket(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      platform: platform ?? this.platform,
      appVersion: appVersion ?? this.appVersion,
      lastSyncAttempt: lastSyncAttempt ?? this.lastSyncAttempt,
      uploaded: uploaded ?? this.uploaded,
      syncAttempts: syncAttempts ?? this.syncAttempts,
    );
  }
}
