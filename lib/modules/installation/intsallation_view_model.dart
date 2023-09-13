import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:video_player/video_player.dart';

class InstallationViewModel extends GetxController {
  void navigateToSeasonsScreen() {
    Get.toNamed(Routes.seasonsScreen);
  }

  var position = Duration.zero;
  var totalVideoDuration = Duration.zero;
  Future setVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/music-and-art-admin-pane-5564c.appspot.com/o/Videos%2Flg-4k-demo-hdr-2018-60fps-elba.mp4?alt=media&token=c10348a9-fec4-4b14-a5d3-5060dbe9d720"))
      ..initialize().then((_) {
        totalVideoDuration = videoController!.value.duration;
        videoController!.play();
        update();
      });
    update();
  }

  VideoPlayerController? videoController;
  void showTrailer(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Container(
                width: Get.width,
                padding: EdgeInsets.all(10),
                child: GetBuilder<InstallationViewModel>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextStyle.textBoldWeight400(
                                text: AuthenticationStrings.trailer,
                                color: AppColors.yellowTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp),
                            InkWell(
                                onTap: () {
                                  controller.videoController?.dispose();
                                  Get.back();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.yellowTextColor),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.yellowTextColor,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        controller.videoController!.value.isInitialized
                            ? Container(
                                height: Get.height * 0.25,
                                width: Get.width,
                                clipBehavior: Clip.none,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  child:
                                      VideoPlayer(controller.videoController!),
                                ),
                              )
                            : Container(
                                height: Get.height * 0.25,
                                width: Get.width,
                                clipBehavior: Clip.none,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                        color: AppColors.yellowTextColor)),
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.appYellow),
                                ),
                              )
                      ],
                    );
                  },
                )));
      },
    );
  }
}
