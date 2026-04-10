class SupabaseConfig {
  const SupabaseConfig._();

  // static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String url = 'https://hnrccaxrvhtbuihfvitc.supabase.co';
  // static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhucmNjYXhydmh0YnVpaGZ2aXRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwNDI1NzUsImV4cCI6MjA3NzYxODU3NX0.L22uzP8ZymKiqNmMl3snMXnK7WvsIdAzKRElclVoUOs';

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}
