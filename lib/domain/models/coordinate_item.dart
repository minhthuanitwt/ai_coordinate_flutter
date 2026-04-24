class CoordinateItem {
  const CoordinateItem({
    required this.id,
    required this.imageUrl,
    required this.prompt,
    required this.createdAt,
    required this.isPosted,
    required this.generationType,
    this.model,
    this.sourceImageStockId,
  });

  final String id;
  final String imageUrl;
  final String prompt;
  final DateTime createdAt;
  final bool isPosted;
  final String generationType;
  final String? model;
  final String? sourceImageStockId;
}
