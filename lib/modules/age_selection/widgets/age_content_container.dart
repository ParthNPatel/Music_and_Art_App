import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/modules/age_selection/age_selection_view_model.dart';

class AgeContentContainer extends StatelessWidget {
  final int index;
  final Function onTap;
  AgeContentContainer({super.key, required this.index, required this.onTap});
  final AgeSelectionViewModel ageSelectionViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Column(
        children: [
          Image.network(
            ageSelectionViewModel.ageContentList[index]['ageImage'],
            height: 104.sp,
            width: 104.sp,
          ),
          SizedBox(
            height: 5.sp,
          ),
          AppTextStyle.textBoldWeight400(
              text: ageSelectionViewModel.ageContentList[index]
                  ['ageContentName'],
              color: AppColors.yellowTextColor,
              fontFamily: 'Poppins',
              fontSize: 18.sp),
        ],
      ),
    );
  }
}
