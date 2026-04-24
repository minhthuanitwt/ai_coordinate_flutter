class MyPageStats {
  const MyPageStats({
    required this.generatedCount,
    required this.generatedCountPublic,
    required this.postedCount,
    required this.likeCount,
    required this.viewCount,
    required this.followerCount,
    required this.followingCount,
  });

  final int generatedCount;
  final bool generatedCountPublic;
  final int postedCount;
  final int likeCount;
  final int viewCount;
  final int followerCount;
  final int followingCount;
}
