import 'package:flutter_test/flutter_test.dart';

import 'package:ai_coordinate_flutter/presentation/screens/auth/login_page.dart';
import 'package:ai_coordinate_flutter/presentation/screens/home/home_page.dart';
import 'package:ai_coordinate_flutter/presentation/screens/shell/app_shell_page.dart';

import '../test_app.dart';

void main() {
  testWidgets('guest lands on public home without login redirect', (tester) async {
    await pumpPerstaApp(tester);

    expect(find.byType(AppShellPage), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);
  });
}
