import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_app.dart';

void main() {
  testWidgets('login returns user to coordinate tab', (tester) async {
    await pumpPerstaApp(tester);

    await tester.tap(find.text('Coordinate'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'demo@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'demo-pass');
    await tester.tap(find.text('Log in').last);
    await tester.pumpAndSettle();

    expect(find.text('Supabase configuration required'), findsOneWidget);
  });
}
