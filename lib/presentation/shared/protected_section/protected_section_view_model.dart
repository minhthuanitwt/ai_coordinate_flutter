import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../screens/auth/auth_state.dart';
import '../../screens/auth/auth_view_model.dart';
import 'protected_section_state.dart';

final protectedSectionViewModelProvider = Provider<ProtectedSectionState>((
  ref,
) {
  final authState = ref.watch(authViewModelProvider);
  final isAuthenticated = authState.isAuthenticated;

  return ProtectedSectionState(
    isAuthenticated: isAuthenticated,
    isRedirecting: !isAuthenticated,
  );
});
