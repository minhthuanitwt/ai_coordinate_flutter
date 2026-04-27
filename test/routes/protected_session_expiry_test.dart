import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_coordinate_flutter/presentation/screens/auth/login_page.dart';

import '../test_app.dart';

void main() {
  testWidgets('signing out from protected flow returns to login', (
    tester,
  ) async {
    await pumpPerstaApp(tester);

    await tester.tap(find.text('Coordinate'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'demo@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'demo-pass');
    await tester.tap(find.text('Log in').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Page'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log out').last);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
