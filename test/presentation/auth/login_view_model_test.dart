import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ai_coordinate_flutter/presentation/providers/auth_session_provider.dart';
import 'package:ai_coordinate_flutter/presentation/screens/auth/login_view_model.dart';
import 'package:ai_coordinate_flutter/services/local_storage_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    LocalStorageService.debugReset();
  });

  test('login view-model validates missing credentials', () async {
    await LocalStorageService.init();
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final success = await container.read(loginViewModelProvider.notifier).signIn();

    expect(success, isFalse);
    expect(
      container.read(loginViewModelProvider).errorCode,
      'missing_credentials',
    );
  });

  test('login view-model signs in using local mock session', () async {
    await LocalStorageService.init();
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(loginViewModelProvider.notifier);
    notifier.updateEmail('demo@example.com');
    notifier.updatePassword('demo-pass');

    final success = await notifier.signIn();
    final session = await container.read(authRepositoryProvider).getCurrentSession();

    expect(success, isTrue);
    expect(session.isAuthenticated, isTrue);
    expect(session.email, 'demo@example.com');
  });
}
