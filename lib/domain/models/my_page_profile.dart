class MyPageProfile {
  const MyPageProfile({
    required this.userId,
    this.nickname,
    this.bio,
    this.avatarUrl,
    this.subscriptionPlan,
    this.email,
  });

  final String userId;
  final String? nickname;
  final String? bio;
  final String? avatarUrl;
  final String? subscriptionPlan;
  final String? email;

  String get displayName {
    final trimmed = nickname?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
    return '';
  }
}
