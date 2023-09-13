import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/services/get_storage_service.dart';

class ProfileViewModel extends GetxController {
  int? isSelect = -1;
  updateIsSelected(int val) {
    isSelect = val;
    update();
  }

  List<dynamic> profileOptionList = [
    ProfileOptionString.profilWechseln,
    ProfileOptionString.aboVerwalten,
    ProfileOptionString.profilLschen,
    ProfileOptionString.abmelden
  ];
  List profileList = [
    ProfileScreenString.thema,
    ProfileScreenString.meinProfil,
    ProfileScreenString.sprache,
    ProfileScreenString.musikStore,
  ];

  deleteUser(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    try {
      await user?.delete();
      await FirebaseAuth.instance.signOut();
      GetStorageServices.logOut();
      print("User account deleted.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print("Error: This operation requires a recent login.");
        Get.back();
        showSnackBar(
            context: context,
            title:
                "Bitte melden Sie sich ab und erneut an, um Ihr Konto zu entfernen");
      } else {
        print("Error: ${e.message}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required BuildContext context, required String title}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  deleteUserDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  AppTextStyle.textBoldWeight400(
                      text: 'Sind Sie sicher, dass Sie dieses Profil löschen?',
                      color: Colors.red,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.sp),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: Get.width,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              color: AppColors.yellowTextColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: AppTextStyle.textBoldWeight400(
                                  text: 'Stornieren',
                                  color: AppColors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            deleteUser(context);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: Get.width,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: AppTextStyle.textBoldWeight400(
                                    text: 'Ja',
                                    color: AppColors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18.sp),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
