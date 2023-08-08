import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/seasons/seasons_view_model.dart';
import 'package:music_and_art/modules/seasons/widgets/season_container.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

class SeasonsScreen extends StatefulWidget {
  SeasonsScreen({Key? key}) : super(key: key);

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  final SeasonsViewModel seasonsViewModel = Get.find();
  @override
  void initState() {
    seasonsViewModel.getSeasonsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.transparent,
      bgImage: AppImages.appBG2,
      needAppBar: false,
      needSingleChildScrollView: false,
      needCustomPadding: true,
      needSafeArea: false,
      needUIStack: true,
      needBearImg: true,
      icon: true,
      needPainterGirlImg: true,
      needSingerBoy: true,
      body: GetBuilder<SeasonsViewModel>(
        builder: (controller) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.sp,
                ),
                AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.intelligenz,
                    color: AppColors.white,
                    fontSize: 32.sp,
                    needPoppins: false),
                SizedBox(height: 20.h),
                controller.setLoading == true
                    ? Container(
                        height: Get.height * 0.30,
                        width: Get.width,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColors.appYellow),
                        ),
                      )
                    : controller.seasonsList.isEmpty
                        ? SizedBox()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 20.h,
                              crossAxisSpacing: 20.h,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.seasonsList.length,
                            itemBuilder: (context, index) {
                              return SeasonContainer(
                                index: index,
                                onTap:
                                    seasonsViewModel.navigateToAgeGroupScreen,
                              );
                            },
                          )
              ]);
        },
      ),
    );
  }

  Widget get padding => SizedBox(height: 10.h);

  Widget get padding20 => SizedBox(height: 20.h);
}
