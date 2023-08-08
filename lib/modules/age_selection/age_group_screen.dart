import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/age_selection/age_selection_view_model.dart';
import 'package:music_and_art/modules/age_selection/widgets/age_selection_container.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

class AgeGroupScreen extends StatefulWidget {
  final String name;

  AgeGroupScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<AgeGroupScreen> createState() => _AgeGroupScreenState();
}

class _AgeGroupScreenState extends State<AgeGroupScreen> {
  final AgeSelectionViewModel ageSelectionViewModel = Get.find();
  @override
  void initState() {
    ageSelectionViewModel.getAgeGroupList(widget.name);
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
        onIconPressed: ageSelectionViewModel.navigationToProfileScreen,
        needCustomBackButton: true,
        onBackButtonPressed: ageSelectionViewModel.navigateToBack,
        icon: true,
        iconValue: AppIcons.profile_icon,
        titleWidget: AppTextStyle.textBoldWeight400(
            text: Strings.wahle_dein,
            color: AppColors.white,
            fontSize: 25.sp,
            textAlign: TextAlign.center,
            needPoppins: false),
        body: GetBuilder<AgeSelectionViewModel>(
          builder: (controller) {
            return Column(children: [
              SizedBox(
                height: 20.sp,
              ),
              controller.setLoading == true
                  ? Container(
                      height: Get.height * 0.50,
                      width: Get.width,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: AppColors.appYellow),
                      ),
                    )
                  : controller.ageGroupList.isEmpty
                      ? SizedBox()
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.ageGroupList.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 30.h),
                          itemBuilder: (context, index) =>
                              AgeSelectionContainer(
                                  index: index,
                                  onTap: ageSelectionViewModel
                                      .navigateToAgeContentScreen),
                        ),
            ]);
          },
        ));
  }

  Widget get padding => SizedBox(height: 10.h);

  Widget get padding20 => SizedBox(height: 20.h);
}
