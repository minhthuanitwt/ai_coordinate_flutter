import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/supabase_coordinate_repository.dart';
import '../../data/repositories/supabase_home_repository.dart';
import '../../data/repositories/supabase_my_page_repository.dart';
import '../../domain/repository/coordinate_repository.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/repository/my_page_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return SupabaseHomeRepository();
});

final coordinateRepositoryProvider = Provider<CoordinateRepository>((ref) {
  return SupabaseCoordinateRepository();
});

final myPageRepositoryProvider = Provider<MyPageRepository>((ref) {
  return SupabaseMyPageRepository();
});
