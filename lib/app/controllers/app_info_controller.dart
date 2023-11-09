import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import '../base/base_custom_controller.dart';

class AppInfoController extends BaseCustomController {
  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isWindows) {
      var windowsDeviceInfo = await deviceInfo.windowsInfo;
      return windowsDeviceInfo.computerName;
    }
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    if (Platform.isMacOS) {
      var macDeviceInfo = await deviceInfo.macOsInfo;
      return macDeviceInfo.computerName;
    }

    if (Platform.isLinux) {
      var linuxDeviceInfo = await deviceInfo.linuxInfo;
      return linuxDeviceInfo.id;
    }
    return '';
  }
}
