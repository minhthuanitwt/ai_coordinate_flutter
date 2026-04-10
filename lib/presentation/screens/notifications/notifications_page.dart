import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../../shared/protected_section/protected_section_page.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return ProtectedSectionPage(
      title: strings.notificationsTitle,
      description: strings.notificationsDescription,
      tag: strings.notificationsBadge,
      icon: Icons.notifications_active_outlined,
    );
  }
}
