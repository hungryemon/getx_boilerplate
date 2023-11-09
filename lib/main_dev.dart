import 'dart:async';
import 'dart:io';

import 'package:window_size/window_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:macos_window_utils/macos_window_utils.dart';

import '/app.dart';
import '/helper/constants/api_constants.dart';
import '/my_shared_preference.dart';
import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import '/helper/utils.dart';
import 'di.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
     await DenpendencyInjection.init();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    
    if (Platform.isMacOS) {
      await WindowManipulator.initialize();
    }

    if (!isPlatformAndroidOrIOS) {
      setWindowTitle('Getx Boilerplate Dev');

      setWindowMinSize(const Size(600, 800));
    }

    HttpOverrides.global = MyHttpOverrides();
    SharedPrefInitialData sharedPrefInitialData =
        await MySharedPreference().getInitialSharedPreference();

    bool isDarkTheme = sharedPrefInitialData.isDarkTheme;
    String savedLocaleLanguageCode =
        sharedPrefInitialData.savedLocaleLanguageCode;
    String savedLocaleCountryCode =
        sharedPrefInitialData.savedLocaleCountryCode;

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
      ));
    }

    EnvConfig devConfig = EnvConfig(
      appName: "Getx Boilerplate Dev",
      baseUrl: ApiConstants.apiBaseUrlDev,
      shouldCollectLog: true,
    );

    BuildConfig.instantiate(
      envType: Environment.DEVELOPMENT,
      envConfig: devConfig,
    );

    runApp(GetxBoilerplate(
      isDarkTheme: isDarkTheme,
      appLocale: Locale(savedLocaleLanguageCode, savedLocaleCountryCode),
    ));
  }, (error, stack) async {
    //Add Error Analytics Function
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
