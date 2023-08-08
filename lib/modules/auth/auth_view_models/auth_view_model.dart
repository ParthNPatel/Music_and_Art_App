import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';

class AuthViewModel extends GetxController {
  void navigateToSignupScreen() {
    Get.toNamed(Routes.signUpScreen);
  }

  void navigateToInstallationScreen() {
    Get.toNamed(Routes.installationScreen);
  }

  bool checkBox1 = false;
  bool checkBox2 = false;
  updateCheckBox1Value(bool val) {
    checkBox1 = val;
    update();
  }

  updateCheckBox2Value(bool val) {
    checkBox2 = val;
    update();
  }

  void termsAndConditionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sp),
              topLeft: Radius.circular(15.sp))),
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: GetBuilder<AuthViewModel>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.allgemeine,
                    fontSize: 24.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                SizedBox(height: 45.h),
                AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.hiermit_explizit,
                    fontSize: 14.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                SizedBox(height: 45.h),
                Row(
                  children: [
                    Checkbox(
                      value: controller.checkBox1,
                      onChanged: (bool? value) {
                        controller.updateCheckBox1Value(value!);
                      },
                    ),
                    AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.den_allgemeine,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Checkbox(
                      value: controller.checkBox2,
                      onChanged: (value) {
                        controller.updateCheckBox2Value(value!);
                      },
                    ),
                    AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.datenschutzrichtlinien,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
