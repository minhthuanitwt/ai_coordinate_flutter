class MyPageImageItem {
  const MyPageImageItem({
    required this.id,
    required this.imageUrl,
    required this.prompt,
    required this.caption,
    required this.isPosted,
    required this.createdAt,
    required this.postedAt,
  });

  final String id;
  final String imageUrl;
  final String? prompt;
  final String? caption;
  final bool isPosted;
  final DateTime? createdAt;
  final DateTime? postedAt;

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
