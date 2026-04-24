import '../../core/models/coordinate_item.dart';
import '../../domain/failures/coordinate_repository_failure.dart';
import '../../domain/repository/coordinate_repository.dart';
import '../../services/supabase_service.dart';

class SupabaseCoordinateRepository implements CoordinateRepository {
  @override
  Future<List<CoordinateItem>> listCoordinateItems({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    final service = SupabaseService.instance;
    if (!service.isConfigured) {
      throw const CoordinateRepositoryFailure('supabase_not_configured');
    }

    final response = await service.client
        .from('generated_images')
        .select(
          'id, image_url, prompt, created_at, is_posted, generation_type, '
          'model, source_image_stock_id',
        )
        .eq('user_id', userId)
        .eq('generation_type', 'coordinate')
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    final rows = response as List<dynamic>;
    return rows
        .map((row) => _mapCoordinateItem(Map<String, dynamic>.from(row as Map)))
        .toList();
  }

  CoordinateItem _mapCoordinateItem(Map<String, dynamic> row) {
    return CoordinateItem(
      id: row['id'] as String? ?? '',
      imageUrl: row['image_url'] as String? ?? '',
      prompt: row['prompt'] as String? ?? '',
      createdAt:
          DateTime.tryParse(row['created_at'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      isPosted: row['is_posted'] as bool? ?? false,
      generationType: row['generation_type'] as String? ?? 'coordinate',
      model: row['model'] as String?,
      sourceImageStockId: row['source_image_stock_id'] as String?,
    );
  }
}
