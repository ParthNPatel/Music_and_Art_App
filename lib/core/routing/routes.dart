import 'package:get/get.dart';
import 'package:music_and_art/modules/age_selection/age_content_screen.dart';
import 'package:music_and_art/modules/age_selection/age_group_screen.dart';
import 'package:music_and_art/modules/auth/auth_screens/login_screen.dart';
import 'package:music_and_art/modules/auth/auth_screens/sign_up_screen.dart';
import 'package:music_and_art/modules/installation/installation_screen.dart';
import 'package:music_and_art/modules/membershipPlan/membership_plan_screen.dart';
import 'package:music_and_art/modules/profile/profile_option_screen.dart';
import 'package:music_and_art/modules/profile/profile_screen.dart';
import 'package:music_and_art/modules/seasons/seasons_screen.dart';
import 'package:music_and_art/modules/termAndConditions/terms_and_condition_screen.dart';
import 'package:music_and_art/modules/videoLecture/video_lecture_screen.dart';

class Routes {
  static const String loginScreen = "/loginScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String installationScreen = "/installationScreen";
  static const String profileScreen = "/profileScreen";
  static const String profileOptionScreen = "/profileOptionScreen";
  static const String membershipPlanScreen = "/membershipPlanScreen";
  static const String videoLectureScreen = "/VideoLectureScreen";
  static const String seasonsScreen = "/seasonsScreen";
  static const String ageGroupScreen = "/ageGroupScreen";
  static const String ageContentScreen = "/ageContentScreen";
  static const String termsAndConditionScreen = "/termsAndConditionScreen";
}

final getRoute = [
  /// login screen
  GetPage(
    name: Routes.loginScreen,
    transition: Transition.native,
    page: () => LoginScreen(),
  ),

  /// signup screen
  GetPage(
    name: Routes.signUpScreen,
    transition: Transition.native,
    page: () => SignUpScreen(),
  ),

  /// signup screen
  GetPage(
    name: Routes.installationScreen,
    transition: Transition.native,
    page: () => InstallationScreen(),
  ),

  /// Profile screen
  GetPage(
    name: Routes.profileScreen,
    transition: Transition.native,
    page: () => ProfileScreen(),
  ),

  /// ProfileOption screen
  GetPage(
    name: Routes.profileOptionScreen,
    transition: Transition.native,
    page: () => ProfileOptionScreen(),
  ),

  /// MembershipPlan screen
  GetPage(
    name: Routes.membershipPlanScreen,
    transition: Transition.native,
    page: () => MembershipPlanScreen(),
  ),

  /// VideoLecture screen
  GetPage(
      name: Routes.videoLectureScreen,
      transition: Transition.native,
      page: () {
        final args = Get.arguments as int;
        return VideoLectureScreen(index: args);
      }),

  /// seasons screen
  GetPage(
    name: Routes.seasonsScreen,
    transition: Transition.native,
    page: () => SeasonsScreen(),
  ),

  /// age group screen
  GetPage(
    name: Routes.ageGroupScreen,
    transition: Transition.native,
    page: () {
      final args = Get.arguments as String;

      return AgeGroupScreen(name: args);
    },
  ),

  /// age content screen
  GetPage(
    name: Routes.ageContentScreen,
    transition: Transition.native,
    page: () {
      final args = Get.arguments;
      return AgeContentScreen(ageGroup: args);
    },
  ),

  ///Terms And Condition Screen
  GetPage(
    name: Routes.termsAndConditionScreen,
    transition: Transition.native,
    page: () {
      return TermsAndConditionScreen();
    },
  ),
];
