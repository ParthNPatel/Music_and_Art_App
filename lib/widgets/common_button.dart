import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_and_art/constants/colors.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? buttonRadius;
  final double? width;
  final double? height;

  const CommonButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.buttonRadius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.sp,
      width: width ?? MediaQuery.of(context).size.width.w,
      child: MaterialButton(
        color: color ?? AppColors.appYellow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(buttonRadius ?? 50.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                fontSize: 22.sp,
                fontFamily: 'Poppins',
                color: AppColors.yellowTextColor,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
