import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static SharedPreferences? _sharedPreferences;

  static const String keyAccessToken = 'accessToken';
  static const String keyUsername = 'userName';

  static Future<PreferenceService> getInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return PreferenceService._();
  }

  PreferenceService._();

  ///Access Token [keyAccessToken]
  set accessToken(String value) {
    _sharedPreferences!.setString(keyAccessToken, value);
  }

  String get accessToken {
    final value = (_sharedPreferences!.getString(keyAccessToken) ?? '');
    return value;
  }

  ///Access Token [keyUsername]
  set username(String value) {
    _sharedPreferences!.setString(keyUsername, value);
  }

  String get username {
    return _sharedPreferences!.getString(keyUsername) ?? '';
  }

  Future<void> clearSession() async {
    await _sharedPreferences!.remove(keyAccessToken);
  }

  Future<void> clearAll() async {
    await _sharedPreferences!.clear();
  }
}
