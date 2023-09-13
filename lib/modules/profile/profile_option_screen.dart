import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/auth/auth_view_models/auth_view_model.dart';
import 'package:music_and_art/modules/profile/profile_view_model/profile_view_model.dart';
import 'package:music_and_art/services/get_storage_service.dart';

class ProfileOptionScreen extends StatelessWidget {
  ProfileOptionScreen({Key? key}) : super(key: key);
  final ProfileViewModel profileViewModel = Get.find();
  final AuthViewModel authViewModel = Get.find();
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
                        height: 30,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle.textBoldWeight400(
                                text: ProfileOptionString.qasimZaidi,
                                color: AppColors.white,
                                fontFamily: 'Poppins',
                                fontSize: 25.sp),
                            SizedBox(
                              height: 8.sp,
                            ),
                            AppTextStyle.textBoldWeight400(
                                text: ProfileOptionString.Jahrealt,
                                color: AppColors.white,
                                fontFamily: 'Poppins',
                                fontSize: 25.sp),
                            ListView.builder(
                              itemCount: controller.profileOptionList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () async {
                                    if (index == 1) {
                                      Get.toNamed(Routes.membershipPlanScreen);
                                    } else if (index == 2) {
                                      controller.deleteUserDialog(context);
                                    } else if (index == 3) {
                                      GetStorageServices.logOut();
                                      authViewModel.signOut();
                                    }
                                  },
                                  title: AppTextStyle.textBoldWeight400(
                                      text: controller.profileOptionList[index],
                                      color: AppColors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 25.sp),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                  contentPadding: EdgeInsets.only(right: 60.sp),
                                );
                              },
                            ),
                            SizedBox(
                              width: 8.sp,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.termsAndConditionScreen);
                              },
                              child: AppTextStyle.textBoldWeight400(
                                  text: ProfileOptionString.impressum,
                                  color: AppColors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
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
          ),
        ],
      ),
    );
  }
}
