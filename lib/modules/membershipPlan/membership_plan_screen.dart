import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/membershipPlan/membership_plan_view_model/membership_plan_view_model.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

class MembershipPlanScreen extends StatelessWidget {
  MembershipPlanScreen({Key? key}) : super(key: key);
  final MemberShipPlanViewModel memberShipPlanViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.white,
      needAppBar: true,
      needSingleChildScrollView: false,
      needCustomPadding: false,
      titleWidget: AppTextStyle.textBoldWeight400(
          text: MembershipPlanString.mitgliedschaft,
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
      needSingerBoy: true,
      body: GetBuilder<MemberShipPlanViewModel>(
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              itemCount: controller.membershipName.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: Get.width,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(46.sp),
                      color: index == 0
                          ? AppColors.purple
                          : index == 1
                              ? AppColors.lightBlue
                              : AppColors.lightOrange),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/membership_box.png',
                        height: 79.sp,
                        width: 90.sp,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle.textBoldWeight400(
                                text: '${controller.membershipName[index]}',
                                color: AppColors.black,
                                fontFamily: 'Poppins',
                                maxLines: 1,
                                fontSize: 20.sp),
                            AppTextStyle.textBoldWeight400(
                                text: MembershipPlanString.dummyText,
                                color: AppColors.hintGrey,
                                fontFamily: 'Poppins',
                                maxLines: 4,
                                fontSize: 10.sp),
                            AppTextStyle.textBoldWeight400(
                                text: MembershipPlanString.price,
                                color: AppColors.yellowTextColor,
                                fontFamily: 'Poppins',
                                maxLines: 1,
                                fontSize: 24.sp),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Container(
                        height: 48.sp,
                        width: 48.sp,
                        child: Transform.scale(
                          scale: 1.1,
                          child: Radio(
                            value: controller.membershipName[index],
                            groupValue: controller.selectedOption,
                            onChanged: (String? value) {
                              controller.changeSelectedValue(value!);
                            },
                            activeColor: AppColors.yellowTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 28.sp,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
