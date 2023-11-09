import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  getInitialSharedPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      bool isDarkTheme = prefs.getBool("isDarkTheme") ?? false;
      String savedLocaleLanguageCode =
          prefs.getString("savedLocaleLanguageCode", ) ?? 'en';
      String savedLocaleCountryCode =
          prefs.getString("savedLocaleCountryCode") ?? 'US';

      return SharedPrefInitialData(
          isDarkTheme: isDarkTheme,
          savedLocaleCountryCode: savedLocaleCountryCode,
          savedLocaleLanguageCode: savedLocaleLanguageCode);
    } catch (e) {
      if (Platform.isWindows) {
        var directory = await getApplicationSupportDirectory();
        // ignore: prefer_interpolation_to_compose_strings
        File(directory.path + r'\' + 'shared_preferences.json').deleteSync();
      }
      return SharedPrefInitialData();
    }
  }
}

class SharedPrefInitialData {
  SharedPrefInitialData(
      {this.isDarkTheme = false,
      this.savedLocaleLanguageCode = 'en',
      this.savedLocaleCountryCode = 'US'});

  bool isDarkTheme;
  String savedLocaleLanguageCode;
  String savedLocaleCountryCode;
}
