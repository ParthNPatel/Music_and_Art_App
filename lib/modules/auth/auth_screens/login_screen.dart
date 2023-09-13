import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/auth/auth_screens/instagram_login_view.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/widgets/common_button.dart';
import 'package:music_and_art/widgets/screen_layout.dart';
import 'package:music_and_art/widgets/text_field_layout.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthViewModel authViewModel = Get.find();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        scaffoldColor: AppColors.transparent,
        bgImage: AppImages.appBG,
        needAppBar: false,
        body: GetBuilder<AuthViewModel>(
          builder: (controller) {
            return Form(
              key: loginFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      controller: controller.loginEmail,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Bitte geben Sie Ihre E-Mail-Adresse ein.   Email';
                        } else if (!val.contains('@')) {
                          return "Bitte eine gültige Email eingeben";
                        }
                        return null;
                      },
                    ),
                    padding,
                    TextFieldLayout(
                      hintText: AuthenticationStrings.hint_password,
                      labelText: AuthenticationStrings.password,
                      controller: controller.loginPassword,
                      isPasswordField: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Bitte Passwort eingeben';
                        }
                        return null;
                      },
                    ),
                    padding20,
                    InkWell(
                      onTap: () {
                        controller.forgetPassWord.clear();
                        controller.forgetPasswordAlertBox(context);
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: AppTextStyle.textBoldWeight400(
                              text: AuthenticationStrings.forget_password,
                              color: AppColors.appYellow,
                              fontSize: 15.sp)),
                    ),
                    padding20,
                    controller.setLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColors.appYellow),
                          )
                        : CommonButton(
                            text: AuthenticationStrings.einloggen,
                            onPressed: () {
                              if (loginFormKey.currentState!.validate()) {
                                controller.setLoadingS(true);
                                controller.login(
                                    email: controller.loginEmail.text,
                                    password: controller.loginPassword.text,
                                    context: context);
                              }
                            },
                          ),
                    padding20,
                    AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.sie_haben,
                        color: AppColors.white,
                        fontSize: 15.sp),
                    InkWell(
                      onTap: controller.navigateToSignupScreen,
                      child: AppTextStyle.textBoldWeight400(
                          text: AuthenticationStrings.anmeldung,
                          color: AppColors.appYellow,
                          fontSize: 15.sp),
                    ),
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
                        GestureDetector(
                          onTap: () {
                            controller
                                .facebookAuthMethod(context)
                                .then((value) {
                              if (value?.user != null) {
                                // controller
                                //     .navigateToInstallationScreen(context);
                                Get.offAllNamed(Routes.installationScreen);
                              } else {}
                            });
                          },
                          child: Container(
                            height: 45.sp,
                            width: 45.sp,
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(AppImages.facebook),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.signInWithGoogle(context);
                          },
                          child: Container(
                            height: 45.sp,
                            width: 45.sp,
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(AppImages.google),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(InstagramView());
                          },
                          child: Container(
                            height: 45.sp,
                            width: 45.sp,
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(AppImages.instagram),
                          ),
                        )
                      ],
                    )
                  ]),
            );
          },
        ));
  }

  Widget get padding => SizedBox(height: 10.h);
  Widget get padding20 => SizedBox(height: 20.h);
}
