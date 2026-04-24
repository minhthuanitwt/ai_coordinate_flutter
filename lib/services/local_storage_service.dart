import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  static SharedPreferences? _prefs;
  static const mockSessionActiveKey = 'mock_session_active';
  static const mockUserEmailKey = 'mock_user_email';
  static const mockUserPasswordKey = 'mock_user_password';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError('LocalStorageService.init() must be called first.');
    }
    return prefs;
  }

  static void debugReset() {
    _prefs = null;
  }
}
