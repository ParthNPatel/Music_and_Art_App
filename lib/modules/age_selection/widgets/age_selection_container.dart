import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/modules/age_selection/age_selection_view_model.dart';

class AgeSelectionContainer extends StatelessWidget {
  final int index;
  final Function onTap;
  AgeSelectionContainer({super.key, required this.index, required this.onTap});
  final AgeSelectionViewModel ageSelectionViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            index == 0
                ? 'assets/images/group_1.png'
                : index == 1
                    ? 'assets/images/group_2.png'
                    : index == 2
                        ? "assets/images/group_3.png"
                        : '${ageSelectionViewModel.ageGroupList[index]['ageImage']}',
            fit: BoxFit.fill,
            height: 119.h,
            width: Get.width,
          ),
        ],
      ),
    );
  }
}
