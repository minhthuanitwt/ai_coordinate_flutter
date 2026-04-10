import 'package:supabase_flutter/supabase_flutter.dart';

import '../configs/supabase_config.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  bool _initialized = false;
  bool _configured = false;

  bool get isConfigured => _configured;

  SupabaseClient get client => Supabase.instance.client;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    _initialized = true;

    if (!SupabaseConfig.isConfigured) {
      _configured = false;
      return;
    }

    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
    _configured = true;
  }
}
