import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import 'helper/language/translation_service.dart';
import '/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '/routes/app_pages.dart';
import '/routes/app_routes.dart';
import 'app/bindings/initial_binding.dart';

// ignore: must_be_immutable
class GetxBoilerplate extends StatefulWidget {
  GetxBoilerplate({
    required this.isDarkTheme,
    required this.appLocale,
    Key? key,
  }) : super(key: key);

  bool isDarkTheme;
  Locale appLocale;

  @override
  State<GetxBoilerplate> createState() => _GetxBoilerplateState();
}

class _GetxBoilerplateState extends State<GetxBoilerplate> {
  final EnvConfig _envConfig = BuildConfig.instance.config;
  List<NavigatorObserver> navigatorObserver = [GetObserver()];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: _envConfig.appName,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: widget.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        defaultTransition: Transition.noTransition,
        locale: widget.appLocale,
        translations: TranslationService(),
        fallbackLocale: TranslationService.bengaliLocale,
        getPages: AppPages.routes,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.SPLASH,
        enableLog: true,
        logWriterCallback: (String text, {bool isError = false}) {
          if (BuildConfig.instance.config.shouldCollectLog) {
            debugPrint("GetxLog: $text");
          }
        },
        smartManagement: SmartManagement.keepFactory,
        navigatorObservers: navigatorObserver,
        builder: (BuildContext context, Widget? _) {
          var child = _!;

          return ResponsiveBreakpoints.builder(
            child: child,
            breakpoints: [
              const Breakpoint(start: 0, end: 400, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
        });
  }
}
