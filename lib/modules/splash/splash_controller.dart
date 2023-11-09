import 'package:get/get.dart';
import 'package:getx_boilerplate/helper/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../../shared/constants/storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(milliseconds: 2000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        goToNamed(AppRoutes.HOME);
      } else {
        goToNamed(AppRoutes.AUTH);
      }
    } catch (e) {
     goToNamed(AppRoutes.AUTH);
    }
  }
}
