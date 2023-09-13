import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';

import 'profile_view_model/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final AuthViewModel authViewModel = Get.find();

  final ProfileViewModel profileViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<ProfileViewModel>(
            builder: (controller) {
              return Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/profileBackground.png'),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.appYellow,
                          )),
                      SizedBox(
                        height: 30.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Row(
                          children: [
                            Container(
                              height: 62.sp,
                              width: 62.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/profileImage.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            AppTextStyle.textBoldWeight400(
                                text: ProfileScreenString.qasimZaidi,
                                color: AppColors.white,
                                fontFamily: 'Poppins',
                                fontSize: 27.sp)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      ListView.builder(
                        itemCount: controller.profileList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 20.sp, right: 70.sp),
                            child: ListTile(
                              selected: controller.isSelect == index,
                              onTap: () {
                                controller.updateIsSelected(index);
                                if (index == 1) {
                                  Get.toNamed(Routes.profileOptionScreen);
                                }
                              },
                              title: AppTextStyle.textBoldWeight400(
                                  text: controller.profileList[index],
                                  color: controller.isSelect == index
                                      ? AppColors.appYellow
                                      : AppColors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 25.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: controller.isSelect == index
                                    ? AppColors.appYellow
                                    : AppColors.white,
                                size: 20.sp,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.sp),
                            ),
                          );
                        },
                      ),
                      // ...List.generate(
                      //   4,
                      //   (index) => Padding(
                      //     padding: EdgeInsets.only(left: 20.sp, right: 70.sp),
                      //     child: ListTile(
                      //       selected: controller.isSelect == index,
                      //       onTap: () {
                      //         controller.updateIsSelected(index);
                      //         Get.toNamed(Routes.profileOptionScreen);
                      //       },
                      //       title: AppTextStyle.textBoldWeight400(
                      //           text: index == 0
                      //               ? ProfileScreenString.thema
                      //               : index == 1
                      //                   ? ProfileScreenString.meinProfil
                      //                   : index == 2
                      //                       ? ProfileScreenString.sprache
                      //                       : index == 3
                      //                           ? ProfileScreenString
                      //                               .musikStore
                      //                           : '',
                      //           color: controller.isSelect == index
                      //               ? AppColors.appYellow
                      //               : AppColors.white,
                      //           fontFamily: 'Poppins',
                      //           fontSize: 25.sp),
                      //       trailing: Icon(
                      //         Icons.arrow_forward_ios_outlined,
                      //         color: controller.isSelect == index
                      //             ? AppColors.appYellow
                      //             : AppColors.white,
                      //         size: 20.sp,
                      //       ),
                      //       contentPadding:
                      //           EdgeInsets.symmetric(horizontal: 15.sp),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                height: Get.height * 0.25,
                child: Image.asset('assets/images/simpleGirl.png')),
          )
        ],
      ),
    );
  }
}
