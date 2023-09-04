import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';

class GetStorageServices {
  AuthViewModel authViewModel = Get.find();
  static GetStorage getStorage = GetStorage();

  /// Keep user logged in:
  static setUserLoggedIn() {
    getStorage.write('isUserLoggedIn', true);
  }

  static getUserLoggedIn() {
    return getStorage.read('isUserLoggedIn');
  }

  /// Log out:
  static logOut() {
    getStorage.remove('isUserLoggedIn');
    Get.offAllNamed(Routes.loginScreen);
  }
}
