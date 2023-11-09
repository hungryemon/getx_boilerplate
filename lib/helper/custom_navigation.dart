import 'package:get/get.dart';

Future goToNamed(String routeName, {dynamic arguments, dynamic parameters, int? id}) async {
  return await Get.toNamed(
    routeName, 
    arguments: arguments, 
    parameters: parameters,
    id: id
    );
}

goToNamedUntil(String routeName) {
  Get.until((route) => Get.currentRoute == routeName);
}

Future goToNamedAndClearLast(String routeName, {dynamic arguments}) async {
  return await Get.offAndToNamed(
    routeName,
    arguments: arguments,
  );
}

Future goToNamedAndClearAll(
  String routeName, {
  dynamic context,
  dynamic arguments,
}) async {
  return await Get.offAllNamed(
    routeName,
    arguments: arguments,
    predicate: (route) => Get.currentRoute == routeName,
  );
}

goBack({dynamic result}) {
  Get.back(result: result);
}

