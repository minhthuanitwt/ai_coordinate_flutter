import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ai_coordinate_flutter/app.dart';
import 'package:ai_coordinate_flutter/presentation/screens/home/home_page.dart';
import 'package:ai_coordinate_flutter/presentation/screens/shell/app_shell_page.dart';

void main() {
  testWidgets('renders phase-1 home shell', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: AiCoordinateApp()));
    await tester.pumpAndSettle();

    expect(find.byType(AppShellPage), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
