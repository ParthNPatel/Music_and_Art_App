import 'package:get/get.dart';
import 'package:music_and_art/core/routing/routes.dart';

class InstallationViewModel extends GetxController {
  void navigateToSeasonsScreen() {
    Get.toNamed(Routes.seasonsScreen);
  }
}
