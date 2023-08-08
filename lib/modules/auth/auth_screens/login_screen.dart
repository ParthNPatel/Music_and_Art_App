import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/widgets/common_button.dart';
import 'package:music_and_art/widgets/screen_layout.dart';
import 'package:music_and_art/widgets/text_field_layout.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthViewModel authViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.transparent,
      bgImage: AppImages.appBG,
      needAppBar: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 40.h),
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.willkommen,
            color: AppColors.appYellow,
            fontSize: 20.sp,
            needPoppins: false),
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.intelligenz,
            color: AppColors.white,
            fontSize: 32.sp,
            needPoppins: false),
        padding20,
        TextFieldLayout(
          hintText: AuthenticationStrings.hint_mail,
          labelText: AuthenticationStrings.email,
        ),
        padding,
        TextFieldLayout(
          hintText: AuthenticationStrings.hint_password,
          labelText: AuthenticationStrings.password,
          isPasswordField: true,
        ),
        padding20,
        Align(
            alignment: Alignment.centerRight,
            child: AppTextStyle.textBoldWeight400(
                text: AuthenticationStrings.forget_password,
                color: AppColors.appYellow,
                fontSize: 15.sp)),
        padding20,
        CommonButton(
          text: AuthenticationStrings.einloggen,
          onPressed: authViewModel.navigateToSignupScreen,
        ),
        padding20,
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.sie_haben,
            color: AppColors.white,
            fontSize: 15.sp),
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.anmeldung,
            color: AppColors.appYellow,
            fontSize: 15.sp),
        padding,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Divider(
                color: Colors.white,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.oder,
                    color: AppColors.appYellow,
                    fontSize: 15.sp)),
            Expanded(
                child: Divider(
              color: Colors.white,
            )),
          ],
        ),
        padding,
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.anmelden,
            color: AppColors.white,
            fontSize: 15.sp),
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.mit,
            color: AppColors.white,
            fontSize: 15.sp),
        padding,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 45.sp,
              width: 45.sp,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppImages.facebook),
            ),
            Container(
              height: 45.sp,
              width: 45.sp,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppImages.google),
            ),
            Container(
              height: 45.sp,
              width: 45.sp,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppImages.instagram),
            )
          ],
        )
      ]),
    );
  }

  Widget get padding => SizedBox(height: 10.h);
  Widget get padding20 => SizedBox(height: 20.h);
}
