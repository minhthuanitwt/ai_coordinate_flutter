import '../../core/models/coordinate_item.dart';

abstract class CoordinateRepository {
  Future<List<CoordinateItem>> listCoordinateItems({
    required String userId,
    int limit = 20,
    int offset = 0,
  });
}
