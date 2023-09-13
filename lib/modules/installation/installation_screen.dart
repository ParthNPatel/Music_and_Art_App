import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/modules/installation/intsallation_view_model.dart';
import 'package:music_and_art/widgets/common_button.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

class InstallationScreen extends StatelessWidget {
  InstallationScreen({Key? key}) : super(key: key);

  final AuthViewModel authViewModel = Get.put(AuthViewModel());
  final InstallationViewModel installationViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        scaffoldColor: AppColors.transparent,
        bgImage: AppImages.appBG,
        needAppBar: false,
        needSingleChildScrollView: false,
        needCustomPadding: true,
        needSafeArea: false,
        needUIStack: true,
        needBearImg: true,
        needPainterBoyImg: true,
        needPainterGirlImg: true,
        needSingerBoy: true,
        body: GetBuilder<InstallationViewModel>(
          builder: (controller) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  AppTextStyle.textBoldWeight400(
                      text: AuthenticationStrings.intelligenz,
                      color: AppColors.white,
                      fontSize: 32.sp,
                      needPoppins: false),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.jahre_1_7,
                        color: AppColors.appYellow,
                        fontSize: 20.sp),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        controller.setVideo();
                        controller.showTrailer(context);
                      },
                      child: Container(
                          height: 40.h,
                          width: 130.w,
                          decoration: BoxDecoration(
                              color: AppColors.greyBlue.withOpacity(.7),
                              borderRadius: BorderRadius.circular(40.h),
                              border: Border.all(
                                  color: AppColors.appYellow, width: 2.w)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_circle_outline,
                                color: AppColors.appYellow,
                                size: 28.sp,
                              ),
                              SizedBox(width: 7.w),
                              AppTextStyle.textBoldWeight400(
                                  text: AuthenticationStrings.trailer,
                                  color: AppColors.appYellow,
                                  fontSize: 20.sp)
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 300.h),
                  CommonButton(
                    text: AuthenticationStrings.installation,
                    onPressed: installationViewModel.navigateToSeasonsScreen,
                  ),
                ]);
          },
        ));
  }

  Widget get padding => SizedBox(height: 10.h);
  Widget get padding20 => SizedBox(height: 20.h);
}
