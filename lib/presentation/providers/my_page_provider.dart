import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repository/my_page_repository.dart';
import '../../services/supabase_my_page_repository.dart';

final myPageRepositoryProvider = Provider<MyPageRepository>((ref) {
  return SupabaseMyPageRepository();
});
