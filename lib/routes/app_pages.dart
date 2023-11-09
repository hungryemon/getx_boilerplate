// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/auth/auth.dart';
import '../modules/home/home.dart';
import '../modules/me/cards/cards_screen.dart';
import '../modules/splash/splash.dart';
import '/routes/app_routes.dart';

class AppPages {
   static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: AppRoutes.REGISTER, page: () => RegisterScreen()),
        GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
      ],
      transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        children: [
          GetPage(name: AppRoutes.CARDS, page: () => CardsScreen()),
        ],
        transition: Transition.downToUp,
        ),
  ];
}
