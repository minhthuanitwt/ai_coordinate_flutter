import 'package:flutter_test/flutter_test.dart';

import 'package:ai_coordinate_flutter/presentation/screens/auth/login_page.dart';

import '../test_app.dart';

void main() {
  testWidgets('guest opening coordinate is redirected to login', (tester) async {
    await pumpPerstaApp(tester);

    await tester.tap(find.text('Coordinate'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Log in'), findsWidgets);
  });
}
