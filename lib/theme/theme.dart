import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required Color backgroundColor,
    required Color backgroundColorSecondary,
    required Color primaryTextColor,
    required Color captionTextColor,
    Color? secondaryTextColor,
    required Color accentColor,
    Color? overLineTextColor,
    Color? dividerColor,
    Color? buttonBackgroundColor,
    required Color buttonTextColor,
    Color? cardBackgroundColor,
    Color? disabledColor,
    required Color errorColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      fontFamily: 'Hind-Siliguri',
      brightness: brightness,
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: backgroundColor, indicatorColor: accentColor),
      canvasColor: cardBackgroundColor,
      cardColor: cardBackgroundColor,
      dividerColor: dividerColor,
      scaffoldBackgroundColor: backgroundColor,
      dividerTheme: DividerThemeData(
        color: dividerColor,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackgroundColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      primaryColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      focusColor: backgroundColorSecondary,
      appBarTheme: AppBarTheme(
        color: cardBackgroundColor,
        iconTheme: IconThemeData(
          color: secondaryTextColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: primaryTextColor,
        size: 20.0,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          secondary: accentColor,
          surface: scaffoldBackgroundColor,
          background: scaffoldBackgroundColor,
          error: errorColor,
          onPrimary: buttonTextColor,
          onSecondary: buttonTextColor,
          onSurface: buttonTextColor,
          onBackground: buttonTextColor,
          onError: buttonTextColor,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle:
            TextStyle(fontFamily: 'Hind-Siliguri-Medium', color: errorColor),
        labelStyle: TextStyle(
          fontFamily: 'Hind-Siliguri-Semi-Bold',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryTextColor.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryTextColor,
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
          fontFamily: 'Hind-Siliguri',
        ),
      ),
      unselectedWidgetColor: Colors.black12,
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind-Siliguri-Bold',
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Hind-Siliguri-Bold',
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          color: primaryTextColor,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Hind-Siliguri-Bold',
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Hind-Siliguri-Bold',
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          color: secondaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Hind-Siliguri-Bold',
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hind-Siliguri-Semi-Bold',
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          color: secondaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Hind-Siliguri-Medium',
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          color: captionTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Hind-Siliguri-Medium',
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          color: primaryTextColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hind-Siliguri-Semi-Bold',
        ),
        bodySmall: baseTextTheme.bodySmall!.copyWith(
          color: captionTextColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Hind-Siliguri-Medium',
        ),
        labelSmall: baseTextTheme.labelSmall!.copyWith(
            color: overLineTextColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Hind-Siliguri-Medium',
            letterSpacing: 0),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          color: primaryTextColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hind-Siliguri-Semi-Bold',
        ),
        titleSmall: baseTextTheme.titleSmall!.copyWith(
          color: primaryTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Hind-Siliguri-Semi-Bold',
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme(
        background: backgroundColor,
        error: errorColor,
        brightness: brightness,
        onBackground: backgroundColor,
        onError: errorColor,
        onPrimary: primaryTextColor,
        onSecondary: secondaryTextColor!,
        onSurface: primaryTextColor,
        primary: primaryTextColor,
        secondary: secondaryTextColor,
        surface: primaryTextColor,
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardBackgroundColor: Colors.white,
      primaryTextColor: Colors.black,
      secondaryTextColor: Colors.black87,
      overLineTextColor: Colors.black54,
      captionTextColor: Colors.black54,
      accentColor: Colors.purple,
      dividerColor:Colors.black26,
      buttonBackgroundColor: Colors.purple,
      buttonTextColor: Colors.black,
      disabledColor:Colors.black12,
      errorColor: Colors.red,
      backgroundColor: const Color(0xFFF9F9FA),
      backgroundColorSecondary: Colors.white);

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: const Color(0xFF232B3A),
        backgroundColorSecondary: Colors.black,
        cardBackgroundColor: Colors.black,
        primaryTextColor: Colors.white,
        secondaryTextColor: Colors.white,
        overLineTextColor: Colors.white,
        captionTextColor: Colors.white,
        accentColor: Colors.purple,
        dividerColor: Colors.black54,
        buttonBackgroundColor: Colors.purple,
        buttonTextColor: Colors.white,
        disabledColor: Colors.black12,
        errorColor: Colors.red,
      );
}
