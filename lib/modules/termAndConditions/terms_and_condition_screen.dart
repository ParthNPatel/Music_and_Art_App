import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.white,
      needAppBar: true,
      needSingleChildScrollView: false,
      needCustomPadding: false,
      titleWidget: AppTextStyle.textBoldWeight400(
          text: ProfileOptionString.impressum,
          color: AppColors.titleColor,
          needPoppins: false,
          maxLines: 1,
          fontSize: 33.sp),
      icon: true,
      pdfPage: false,
      onBackButtonPressed: () {
        Get.back();
      },
      iconValue: 'assets/icons/appbar_icon.png',
      onIconPressed: () {
        Get.toNamed(Routes.profileScreen);
      },
      needCustomBackButton: true,
      needSafeArea: false,
      needUIStack: true,
      needSingerBoy: false,
      body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextStyle.textBoldWeight400(
                    text:
                        "Introduction\nThese Website Standard Terms and Conditions written on this webpage shall manage your use of our website, Webiste Name accessible at Website.com.\n\nThese Terms will be applied fully and affect to your use of this Website. By using this Website, you agreed to accept all terms and conditions written in here. You must not use this Website if you disagree with any of these Website Standard Terms and Conditions.\n\nMinors or people below 18 years old are not allowed to use this Website.\n\nIntellectual Property Rights\nOther than the content you own, under these Terms, Company Name and/or its licensors own all the intellectual property rights and materials contained in this Website.\n\nYou are granted limited license only for purposes of viewing the material contained on this Website.",
                    color: AppColors.titleColor,
                    maxLines: 40,
                    fontSize: 15.sp),
              ],
            ),
          )),
    );
  }
}
