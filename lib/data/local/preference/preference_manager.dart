// ignore_for_file: constant_identifier_names


import '../../model/response/users_response.dart';

abstract class PreferenceManager {
  static const KEY_SAVED_LOCALE_LANGUAGE_CODE = "savedLocaleLanguageCode";
  static const KEY_SAVED_LOCALE_COUNTRY_CODE = "savedLocaleCountryCode";
  static const KEY_IS_DARK_THEME = "isDarkTheme";
  static const KEY_APP_OPEN_COUNT = 'appOpenCount';

  Future<void> updateTokens({
    String? accessToken,
    String? refreshToken,
    String? accessTokenExp,
  });

  Future<String> getRefreshToken();

  Future<String> getAccessToken();

  Future<String> getAccessTokenString();
  Future<String> getRefreshTokenString();
  Future<String> getAccessTokenTimeExp();

  Future<bool> isUserLoggedIn();

  Future<CurrentUserData> getCurrentUser();

  Future<int> getMyId();

  Future<String> getString(String key, {String defaultValue = ""});

  Future<bool> setString(String key, String value);

  Future<int> getInt(String key, {int defaultValue = 0});

  Future<bool> setInt(String key, int value);

  Future<double> getDouble(String key, {double defaultValue = 0.0});

  Future<bool> setDouble(String key, double value);

  Future<bool> getBool(String key, {bool defaultValue = false});

  Future<bool> setBool(String key, bool value);

  Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []});

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();
}
