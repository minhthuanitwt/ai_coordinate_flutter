import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/models/bootstrap_status.dart';
import '../../services/local_storage_service.dart';
import '../../services/supabase_service.dart';

typedef AppBootstrapState = BootstrapStatus;

final appBootstrapProvider = FutureProvider<AppBootstrapState>((ref) async {
  await LocalStorageService.init();
  await SupabaseService.instance.initialize();

  return BootstrapStatus(
    supabaseConfigured: SupabaseService.instance.isConfigured,
  );
});
