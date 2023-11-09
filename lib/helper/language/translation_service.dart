import "package:flutter/material.dart";
import "package:get/get.dart";

import "bn_bd.dart";
import "en_US.dart";

class TranslationService extends Translations {
  static const Locale englishLocale = Locale("en", "US");
  static const Locale bengaliLocale = Locale("bn", "BD");

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_us,
        'bn_BN': bn_bd,
      };

  
}
