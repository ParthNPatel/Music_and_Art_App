import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/modules/seasons/seasons_view_model.dart';

class SeasonContainer extends StatelessWidget {
  final int index;
  final Function onTap;
  SeasonContainer({super.key, required this.index, required this.onTap});
  final SeasonsViewModel seasonsViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(47.sp),
            boxShadow: [
              BoxShadow(
                  color: AppColors.white,
                  offset: Offset(index < 2 ? 2.5 : -2.5, 5.5))
            ],
            image: DecorationImage(
                image: NetworkImage(
                    seasonsViewModel.seasonsList[index]['categoryImage']))),
      ),
    );
  }
}
