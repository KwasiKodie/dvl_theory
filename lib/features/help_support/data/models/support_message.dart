class SupportMessage {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final String platform;
  final String appVersion;
  final int syncAttempts;
  final DateTime? lastSyncAttempt;
  final bool uploaded;

  const SupportMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.platform,
    required this.appVersion,
    this.uploaded = false,
    this.lastSyncAttempt,
    this.syncAttempts = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'platform': platform,
      'appVersion': appVersion,
      'uploaded': uploaded,
      'lastSyncAttempt': lastSyncAttempt?.toIso8601String(),
      'syncAttempts': syncAttempts,
    };
  }

  factory SupportMessage.fromMap(Map<dynamic, dynamic> map) {
    return SupportMessage(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      subject: map['subject']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      platform: map['platform']?.toString() ?? '',
      appVersion: map['appVersion']?.toString() ?? '',
      uploaded: map['uploaded'] == true,
      syncAttempts: (map['syncAttempts'] as num?)?.toInt() ?? 0,
      lastSyncAttempt: map['lastSyncAttempt'] != null
          ? DateTime.tryParse(map['lastSyncAttempt'].toString())
          : null,
    );
  }

  SupportMessage copyWith({
    String? id,
    String? name,
    String? email,
    String? subject,
    String? message,
    String? platform,
    String? appVersion,
    bool? uploaded,
    int? syncAttempts,
    DateTime? lastSyncAttempt,
  }) {
    return SupportMessage(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      platform: platform ?? this.platform,
      appVersion: appVersion ?? this.appVersion,
      uploaded: uploaded ?? this.uploaded,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastSyncAttempt: lastSyncAttempt ?? this.lastSyncAttempt,
    );
  }
}
