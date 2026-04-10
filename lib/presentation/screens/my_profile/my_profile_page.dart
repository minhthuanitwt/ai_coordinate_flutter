import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../shared/protected_section/protected_section_page.dart';

@RoutePage()
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return ProtectedSectionPage(
      title: strings.myPageTitle,
      description: strings.myPageDescription,
      tag: strings.myPageBadge,
      icon: Icons.person_outline,
    );
  }
}
