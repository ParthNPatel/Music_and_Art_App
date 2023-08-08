import 'package:get/get.dart';
import 'package:music_and_art/modules/age_selection/age_selection_view_model.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/modules/installation/intsallation_view_model.dart';
import 'package:music_and_art/modules/membershipPlan/membership_plan_view_model/membership_plan_view_model.dart';
import 'package:music_and_art/modules/profile/profile_view_model/profile_view_model.dart';
import 'package:music_and_art/modules/seasons/seasons_view_model.dart';
import 'package:music_and_art/modules/videoLecture/video_lecture_view_model/video_lecture_view_model.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel(), fenix: true);
    Get.lazyPut(() => MemberShipPlanViewModel(), fenix: true);
    Get.lazyPut(() => VideoLectureViewModel(), fenix: true);
    Get.lazyPut(() => InstallationViewModel(), fenix: true);
    Get.lazyPut(() => SeasonsViewModel(), fenix: true);
    Get.lazyPut(() => AgeSelectionViewModel(), fenix: true);
  }
}
