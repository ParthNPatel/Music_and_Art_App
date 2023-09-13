import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/widgets/common_button.dart';
import 'package:music_and_art/widgets/screen_layout.dart';
import 'package:music_and_art/widgets/text_field_layout.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  GlobalKey<FormState> signUoFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        scaffoldColor: AppColors.transparent,
        bgImage: AppImages.appBG,
        needAppBar: false,
        body: Form(
          key: signUoFormKey,
          child: GetBuilder<AuthViewModel>(
            builder: (controller) {
              return Column(
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
                      hintText: AuthenticationStrings.benutzer_namen_eingeben,
                      labelText: AuthenticationStrings.benutzername,
                      controller: controller.signUserName,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Bitte geben sie einen Benutzernamen ein.';
                        }
                        return null;
                      },
                    ),
                    padding20,
                    TextFieldLayout(
                      hintText: AuthenticationStrings.hint_mail,
                      labelText: AuthenticationStrings.email,
                      controller: controller.signUpEmail,
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
                      labelText: AuthenticationStrings.passwort_eingeben,
                      isPasswordField: true,
                      controller: controller.signPassword,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Bitte Passwort eingeben';
                        }
                        return null;
                      },
                    ),
                    padding,
                    TextFieldLayout(
                      hintText: AuthenticationStrings.hint_password,
                      labelText: AuthenticationStrings.passwort_erneut_eingeben,
                      isPasswordField: true,
                      validator: (val) {
                        if (controller.signPassword.text != val) {
                          return 'Bitte geben Sie dasselbe Passwort ein.';
                        }
                        return null;
                      },
                    ),
                    padding20,
                    controller.setLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColors.appYellow),
                          )
                        : CommonButton(
                            text: AuthenticationStrings.anmeldung,
                            onPressed: () {
                              if (signUoFormKey.currentState!.validate()) {
                                if (controller.checkBox1 &&
                                    controller.checkBox2) {
                                  controller.setLoadingS(true);
                                  controller.signUp(
                                    email: controller.signUpEmail.text,
                                    password: controller.signPassword.text,
                                    context: context,
                                  );
                                } else {
                                  Get.showSnackbar(GetSnackBar(
                                    title: AuthenticationStrings.terms,
                                    message:
                                        AuthenticationStrings.terms_message,
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red.shade400,
                                  ));
                                }
                              }

                              // controller.navigateToInstallationScreen(context);
                            },
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAllNamed(Routes.loginScreen);
                                },
                              style: TextStyle(
                                  color: AppColors.appYellow,
                                  fontSize: 15.sp,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins'))
                        ])),
                    padding,
                    InkWell(
                      onTap: () {
                        controller.termsAndConditionBottomSheet(context);
                      },
                      child: AppTextStyle.textBoldWeight400(
                          text: AuthenticationStrings.agb,
                          color: AppColors.white,
                          fontSize: 15.sp),
                    )
                  ]);
            },
          ),
        ));
  }

  Widget get padding => SizedBox(height: 10.h);

  Widget get padding20 => SizedBox(height: 20.h);
}
