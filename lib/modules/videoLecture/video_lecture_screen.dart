import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/widgets/screen_layout.dart';

import 'video_lecture_view_model/video_lecture_view_model.dart';

class VideoLectureScreen extends StatefulWidget {
  final int index;
  const VideoLectureScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<VideoLectureScreen> createState() => _VideoLectureScreenState();
}

class _VideoLectureScreenState extends State<VideoLectureScreen> {
  VideoLectureViewModel videoLectureViewModel = Get.find();

  @override
  void initState() {
    // videoLectureViewModel.setAudio();
    videoLectureViewModel.onAudioDurationChange();
    videoLectureViewModel.onAudioPositionChange();
    super.initState();
  }

  @override
  void dispose() {
    videoLectureViewModel.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      scaffoldColor: AppColors.white,
      needAppBar: true,
      needSingleChildScrollView: false,
      needCustomPadding: false,
      titleWidget: AppTextStyle.textBoldWeight400(
          text: VideoLectureString.video,
          color: AppColors.titleColor,
          needPoppins: false,
          maxLines: 1,
          fontSize: 33.sp),
      icon: true,
      backButtonColor: AppColors.black,
      onBackButtonPressed: () {
        Get.back();
      },
      onIconPressed: () {
        Get.toNamed(Routes.profileScreen);
      },
      iconValue: 'assets/icons/appbar_icon.png',
      needCustomBackButton: true,
      needSafeArea: false,
      needUIStack: true,
      needSingerBoy: true,
      body: GetBuilder<VideoLectureViewModel>(
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  child: Image.asset(
                    'assets/images/video_lacture_thumb.png',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle.textBoldWeight400(
                          text: VideoLectureString.lektion,
                          color: AppColors.black,
                          fontFamily: 'Poppins',
                          fontSize: 26.sp),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 24.sp,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: AppTextStyle.textBoldWeight400(
                      text: VideoLectureString.deutscheVideoLektion,
                      color: AppColors.videoHint,
                      fontFamily: 'Poppins',
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Slider(
                  value: controller.currentPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: controller.totalDuration.inSeconds.toDouble(),
                  onChanged: (double value) async {
                    final position = Duration(seconds: value.toInt());
                    await controller.audioPlayer.seek(position);
                    await controller.audioPlayer.resume();
                    controller.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                  activeColor: AppColors.appYellow,
                  secondaryActiveColor: Colors.red,
                  inactiveColor: Colors.grey.withOpacity(0.5),
                  thumbColor: AppColors.appYellow,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextStyle.textBoldWeight400(
                          text:
                              '${controller.printDuration(controller.currentPosition)}',
                          color: AppColors.black,
                          fontFamily: 'Poppins',
                          fontSize: 11.sp),
                      AppTextStyle.textBoldWeight400(
                          text:
                              '${controller.printDuration(controller.totalDuration)}',
                          color: AppColors.black,
                          fontFamily: 'Poppins',
                          fontSize: 11.sp),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.forward_10,
                          color: AppColors.audioYellow,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          controller.cutAudioFromEnd();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.fast_rewind,
                          color: AppColors.audioYellow,
                          size: 24.sp,
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        height: 49.sp,
                        width: 49.sp,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.audioButtonColor),
                        child: IconButton(
                          icon: Icon(
                            controller.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          onPressed: controller.audioButtonPress,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.fast_forward,
                          color: AppColors.audioYellow,
                          size: 24.sp,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.forward_10,
                          color: AppColors.audioYellow,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          controller.cutAudioFromStart();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
