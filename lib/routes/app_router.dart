import 'package:auto_route/auto_route.dart';

import '../presentation/screens/auth/login_page.dart';
import '../presentation/screens/auth/signup_page.dart';
import '../presentation/screens/challenge/challenge_page.dart';
import '../presentation/screens/coordinate/coordinate_page.dart';
import '../presentation/screens/home/home_page.dart';
import '../presentation/screens/my_profile/my_profile_page.dart';
import '../presentation/screens/notifications/notifications_page.dart';
import '../presentation/screens/shell/app_shell_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AppShellRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, path: '', initial: true),
        AutoRoute(page: CoordinateRoute.page, path: 'coordinate'),
        AutoRoute(page: ChallengeRoute.page, path: 'challenge'),
        AutoRoute(page: NotificationsRoute.page, path: 'notifications'),
        AutoRoute(page: MyProfileRoute.page, path: 'my-page'),
      ],
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignupRoute.page, path: '/signup'),
  ];
}
