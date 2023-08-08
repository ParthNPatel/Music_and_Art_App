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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final AuthViewModel authViewModel = Get.put(AuthViewModel());

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
          hintText: AuthenticationStrings.benutzer_namen_eingeben,
          labelText: AuthenticationStrings.benutzername,
        ),
        padding20,
        TextFieldLayout(
          hintText: AuthenticationStrings.hint_mail,
          labelText: AuthenticationStrings.email,
        ),
        padding,
        TextFieldLayout(
          hintText: AuthenticationStrings.hint_password,
          labelText: AuthenticationStrings.passwort_eingeben,
          isPasswordField: true,
        ),
        padding,
        TextFieldLayout(
          hintText: AuthenticationStrings.hint_password,
          labelText: AuthenticationStrings.passwort_erneut_eingeben,
          isPasswordField: true,
        ),
        padding20,
        CommonButton(
          text: AuthenticationStrings.anmeldung,
          onPressed: authViewModel.navigateToInstallationScreen,
        ),
        padding20,
        AppTextStyle.textBoldWeight400(
            text: AuthenticationStrings.bereits_ein,
            color: AppColors.white,
            fontSize: 15.sp),
        RichText(
            text: TextSpan(
                text: AuthenticationStrings.account,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15.sp,
                    fontFamily: 'Poppins'),
                children: [
              TextSpan(
                  text: AuthenticationStrings.einloggen,
                  style: TextStyle(
                      color: AppColors.appYellow,
                      fontSize: 15.sp,
                      decoration: TextDecoration.underline,
                      fontFamily: 'Poppins'))
            ])),
        padding,
        InkWell(
          onTap: () {
            authViewModel.termsAndConditionBottomSheet(context);
          },
          child: AppTextStyle.textBoldWeight400(
              text: AuthenticationStrings.agb,
              color: AppColors.white,
              fontSize: 15.sp),
        )
      ]),
    );
  }

  Widget get padding => SizedBox(height: 10.h);
  Widget get padding20 => SizedBox(height: 20.h);
}
