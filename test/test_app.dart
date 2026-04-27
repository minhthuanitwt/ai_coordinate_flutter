import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ai_coordinate_flutter/app.dart';
import 'package:ai_coordinate_flutter/domain/models/bootstrap_status.dart';
import 'package:ai_coordinate_flutter/i18n/strings.g.dart';
import 'package:ai_coordinate_flutter/presentation/providers/app_bootstrap_provider.dart';
import 'package:ai_coordinate_flutter/services/local_storage_service.dart';

Future<ProviderContainer> pumpPerstaApp(
  WidgetTester tester, {
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  LocalStorageService.debugReset();
  await LocalStorageService.init();
  await LocaleSettings.setLocale(AppLocale.en);

  final container = ProviderContainer(
    overrides: [
      appBootstrapProvider.overrideWith(
        (ref) async => const BootstrapStatus(supabaseConfigured: false),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    TranslationProvider(
      child: UncontrolledProviderScope(
        container: container,
        child: const AiCoordinateApp(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}
