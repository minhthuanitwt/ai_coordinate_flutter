import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth/auth_state.dart';
import '../auth/auth_view_model.dart';
import 'app_shell_state.dart';

final appShellStateProvider = Provider<AppShellState>((ref) {
  final authState = ref.watch(authViewModelProvider);
  return AppShellState(
    email: authState.email,
    isAuthenticated: authState.isAuthenticated,
  );
});

final appShellViewModelProvider = Provider<AppShellViewModel>(
  AppShellViewModel.new,
);

class AppShellViewModel {
  const AppShellViewModel(this.ref);

  final Ref ref;

  Future<void> signOut() {
    return ref.read(authViewModelProvider.notifier).signOut();
  }
}
