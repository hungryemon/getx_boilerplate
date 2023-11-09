import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/app/base/base_controller.dart';
import '/data/local/preference/preference_manager.dart';
import '../../helper/language/translation_service.dart';

abstract class BaseCustomController extends BaseController {
  final PreferenceManager preferenceManager =
      Get.find(tag: (PreferenceManager).toString());

  RxBool isTicketOverlayShown = true.obs;

  Future<void> changeLocale(
      {Locale? toLocale, Function()? onUpdateLocale}) async {
    Future<void> updateLocale;

    if (toLocale != null) {
      Locale tempToLocale = toLocale == TranslationService.bengaliLocale
          ? TranslationService.bengaliLocale
          : TranslationService.englishLocale;
      updateLocale = Get.updateLocale(tempToLocale);
    } else {
      Get.locale! == TranslationService.bengaliLocale
          ? updateLocale = Get.updateLocale(TranslationService.englishLocale)
          : updateLocale = Get.updateLocale(TranslationService.bengaliLocale);
    }
    if (onUpdateLocale != null) {
      onUpdateLocale();
    }

    return await updateLocale;
  }

  void changeStatusBarTheme({Brightness? statusBarBrightness}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(Get.context!).colorScheme.background,
      systemNavigationBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      statusBarIconBrightness: statusBarBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: statusBarBrightness,
    ));
  }

  void changeThemeMode(
      {required ThemeMode toThemeMode, Function()? onUpdateTheme}) {
    ThemeMode tempToThemeMode =
        toThemeMode == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light;

    Get.changeThemeMode(tempToThemeMode);

    if (onUpdateTheme != null) {
      onUpdateTheme();
    }
    if (Platform.isIOS) {
      changeStatusBarTheme(
          statusBarBrightness: toThemeMode == ThemeMode.dark
              ? Brightness.dark
              : Brightness.light);
    }
  }

////////////////////////////////////////LOGOUT///////////////////////////////////////////

  @override
  void onDetached() {
    logger.d("BaseController onDetached");
  }

  @override
  void onInactive() {
    logger.d("BaseController onInactive");
  }

  @override
  void onPaused() {
    logger.d("BaseController onPaused");
  }

  @override
  void onResumed() {
    logger.d("BaseController onResumed");
  }

  @override
  void onHidden() {
    logger.d("BaseController onHidden");
  }
}
