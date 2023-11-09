import '/helper/custom_navigation.dart';

class NavigatorHelper {
  static void popLastScreens({
    required int popCount,
  }) {
    int count = 0;
    while (count < popCount) {
      goBack();
      count++;
    }
  }
}
