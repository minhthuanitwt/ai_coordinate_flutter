import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/auth_session.dart';

typedef AuthState = AsyncValue<AuthSession>;

extension AuthStateX on AuthState {
  bool get isAuthenticated => valueOrNull?.isAuthenticated ?? false;

  String? get email => valueOrNull?.email;
}
