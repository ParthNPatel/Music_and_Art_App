import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageViewer extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const SvgImageViewer(
      {Key? key, required this.assetName, this.height, this.width, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        assetName,
        height: height ?? 8.h,
        width: width ?? 8.w,
        fit: fit ?? BoxFit.fitHeight,
      ),
    );
  }
}
