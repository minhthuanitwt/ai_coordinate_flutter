import '../../../services/supabase_service.dart';

class AppShellState {
  const AppShellState({required this.email, required this.isAuthenticated});

  final String? email;
  final bool isAuthenticated;

  bool get isSupabaseConfigured => SupabaseService.instance.isConfigured;
}
