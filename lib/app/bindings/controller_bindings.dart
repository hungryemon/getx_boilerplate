import 'package:get/get.dart';
import 'package:getx_boilerplate/app/controllers/app_info_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
      Get.put(AppInfoController(), permanent: true);
  }
}
