import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/models/auth_session.dart';
import '../../domain/repository/auth_repository.dart';
import '../../services/supabase_auth_repository.dart';
import '../../services/supabase_service.dart';

enum ProtectedDestination { coordinate, challenge, notifications, myPage }

extension ProtectedDestinationTabIndex on ProtectedDestination {
  int get tabIndex => switch (this) {
    ProtectedDestination.coordinate => 1,
    ProtectedDestination.challenge => 2,
    ProtectedDestination.notifications => 3,
    ProtectedDestination.myPage => 4,
  };
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository(service: SupabaseService.instance);
});

final authSessionProvider = StreamProvider<AuthSession>((ref) {
  return ref.watch(authRepositoryProvider).watchSession();
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final session = ref.watch(authSessionProvider).valueOrNull;
  return session?.isAuthenticated ?? false;
});

final authRedirectTargetProvider = StateProvider<ProtectedDestination?>(
  (ref) => null,
);
