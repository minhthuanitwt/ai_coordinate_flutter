import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../shared/protected_section/protected_section_page.dart';

@RoutePage()
class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return ProtectedSectionPage(
      title: strings.challengeTitle,
      description: strings.challengeDescription,
      tag: strings.challengeBadge,
      icon: Icons.auto_awesome_outlined,
    );
  }
}
