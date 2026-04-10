class HomeBannerItem {
  const HomeBannerItem({
    required this.id,
    required this.imageUrl,
    required this.alt,
    this.linkUrl,
  });

  final String id;
  final String imageUrl;
  final String alt;
  final String? linkUrl;
}
