import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/age_selection/age_selection_view_model.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

import 'widgets/age_content_container.dart';

class AgeContentScreen extends StatefulWidget {
  final String? ageGroup;
  AgeContentScreen({Key? key, this.ageGroup}) : super(key: key);

  @override
  State<AgeContentScreen> createState() => _AgeContentScreenState();
}

class _AgeContentScreenState extends State<AgeContentScreen> {
  final AgeSelectionViewModel ageSelectionViewModel = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.transparent,
      bgImage: AppImages.appBG2,
      needAppBar: true,
      needSingleChildScrollView: false,
      needCustomPadding: true,
      needSafeArea: false,
      needUIStack: true,
      needBearImg: false,
      needPainterGirlImg: true,
      needSingerBoy: true,
      backButtonColor: AppColors.white,
      needCustomBackButton: true,
      onBackButtonPressed: ageSelectionViewModel.navigateToBack,
      icon: true,
      onIconPressed: ageSelectionViewModel.navigationToProfileScreen,
      iconValue: AppIcons.profile_icon,
      titleWidget: AppTextStyle.textBoldWeight400(
          text:
              '${widget.ageGroup!.split(' ').first}\n ${widget.ageGroup!.split(' ').last}',
          color: AppColors.white,
          fontSize: 25.sp,
          textAlign: TextAlign.center,
          needPoppins: false),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<AgeSelectionViewModel>(
          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: 50.h),
                controller.setLoading == true
                    ? Container(
                        height: Get.height * 0.50,
                        width: Get.width,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColors.appYellow),
                        ),
                      )
                    : controller.ageContentList.isEmpty
                        ? SizedBox()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.65,
                              mainAxisSpacing: 10.h,
                              crossAxisSpacing: 10.h,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.ageContentList.length,
                            itemBuilder: (context, index) {
                              return AgeContentContainer(
                                index: index,
                                onTap: ageSelectionViewModel
                                    .navigateToVideoLectureScreen,
                              );
                            },
                          )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get padding => SizedBox(height: 10.h);

  Widget get padding20 => SizedBox(height: 20.h);
}
