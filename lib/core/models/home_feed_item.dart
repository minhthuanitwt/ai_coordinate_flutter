class HomeFeedItem {
  const HomeFeedItem({
    required this.id,
    required this.imageUrl,
    required this.postedAt,
    this.prompt,
    this.caption,
    this.userId,
    this.creatorName,
    this.creatorAvatarUrl,
    this.likeCount,
    this.commentCount,
    this.viewCount,
  });

  final String id;
  final String imageUrl;
  final DateTime postedAt;
  final String? prompt;
  final String? caption;
  final String? userId;
  final String? creatorName;
  final String? creatorAvatarUrl;
  final int? likeCount;
  final int? commentCount;
  final int? viewCount;

  String get previewText {
    final trimmedCaption = caption?.trim();
    if (trimmedCaption != null && trimmedCaption.isNotEmpty) {
      return trimmedCaption;
    }

    final trimmedPrompt = prompt?.trim();
    if (trimmedPrompt != null && trimmedPrompt.isNotEmpty) {
      return trimmedPrompt;
    }

    return '';
  }
}
