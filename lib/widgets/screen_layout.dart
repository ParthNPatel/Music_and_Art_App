import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_and_art/constants/assets.dart';
import 'package:music_and_art/constants/colors.dart';

class ScreenLayout extends StatelessWidget {
  final Widget body;
  final Widget? titleWidget;
  final String bgImage;
  final Color? bgColor;
  final bool icon;
  final bool needBackBtn;
  final bool needCustomBackButton;
  final String? iconValue;
  final VoidCallback? onIconPressed;
  final String text;
  final bool needCustomPadding;
  final double? horizontalPadding;
  final double? verticalPadding;
  final VoidCallback? onBackButtonPressed;
  final bool needCustomAppBar;
  final bool needAppBar;
  final AppBar? customAppBar;
  final bool needSingleChildScrollView;
  final bool pdfPage;
  final Function? pdfIconPressed;
  final Color? scaffoldColor;
  final Widget? bottomSheetWidget;
  final bool setBottomInsetValue;
  final bool needSafeArea;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool needUIStack;
  final bool needPainterBoyImg;
  final bool needBearImg;
  final bool needPainterGirlImg;
  final bool needSingerBoy;
  final Color? backButtonColor;

  const ScreenLayout({
    Key? key,
    required this.body,
    this.bgImage = '',
    this.iconValue,
    this.icon = false,
    this.text = '',
    this.needBackBtn = false,
    this.titleWidget,
    this.needCustomPadding = true,
    this.horizontalPadding,
    this.verticalPadding,
    this.onIconPressed,
    this.onBackButtonPressed,
    this.needCustomBackButton = false,
    this.customAppBar,
    this.needCustomAppBar = false,
    this.needSingleChildScrollView = true,
    this.bgColor,
    this.pdfPage = false,
    this.pdfIconPressed,
    this.scaffoldColor,
    this.bottomSheetWidget,
    this.setBottomInsetValue = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.needAppBar = true,
    this.needSafeArea = true,
    this.needUIStack = false,
    this.needPainterBoyImg = false,
    this.needBearImg = false,
    this.needPainterGirlImg = false,
    this.needSingerBoy = false,
    this.backButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bgImage.isEmpty
            ? SizedBox()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  bgImage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
        Scaffold(
          bottomSheet: bottomSheetWidget,
          backgroundColor: scaffoldColor ?? Colors.white,
          resizeToAvoidBottomInset: setBottomInsetValue,
          appBar: needAppBar
              ? needCustomAppBar
                  ? customAppBar
                  : AppBar(
                      leading: needCustomBackButton
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: backButtonColor ?? AppColors.appYellow,
                              ),
                              onPressed: onBackButtonPressed,
                            )
                          : null,
                      automaticallyImplyLeading: needBackBtn,
                      backgroundColor: scaffoldColor ?? Colors.blue,
                      title: titleWidget,
                      centerTitle: true,
                      elevation: 0.0,
                      actions: [
                        pdfPage
                            ? PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    height: 0,
                                    onTap: () {
                                      pdfIconPressed!();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 4.h, bottom: 4.h),
                                      child: Text('',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                    value: 1,
                                  ),
                                ],
                                icon: Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              )
                            : icon
                                ? IconButton(
                                    onPressed: onIconPressed,
                                    icon: Image.asset(
                                      iconValue!,
                                      height: 34.sp,
                                      width: 34.sp,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(right: 15.w),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          pdfIconPressed!();
                                        },
                                        child: Text(
                                          text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                      ],
                    )
              : null,
          floatingActionButton: floatingActionButton ?? null,
          floatingActionButtonLocation: floatingActionButtonLocation ?? null,
          body: needSingleChildScrollView
              ? needSafeArea
                  ? SafeArea(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: needCustomPadding
                              ? EdgeInsets.symmetric(
                                  horizontal: horizontalPadding ?? 32.w,
                                  vertical: verticalPadding ?? 15.h)
                              : EdgeInsets.zero,
                          child: body,
                        ),
                      ),
                    )
                  : needUIStack
                      ? Stack(children: [
                          SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Padding(
                                padding: needCustomPadding
                                    ? EdgeInsets.symmetric(
                                        horizontal: horizontalPadding ?? 32.w,
                                        vertical: verticalPadding ?? 15.h)
                                    : EdgeInsets.zero,
                                child: body,
                              ))
                        ])
                      : SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: needCustomPadding
                                ? EdgeInsets.symmetric(
                                    horizontal: horizontalPadding ?? 32.w,
                                    vertical: verticalPadding ?? 15.h)
                                : EdgeInsets.zero,
                            child: body,
                          ),
                        )
              : needSafeArea
                  ? SafeArea(
                      child: Padding(
                      padding: needCustomPadding
                          ? EdgeInsets.symmetric(
                              horizontal: horizontalPadding ?? 32.w,
                              vertical: verticalPadding ?? 15.h)
                          : EdgeInsets.zero,
                      child: body,
                    ))
                  : needUIStack
                      ? Stack(children: [
                          if (needBearImg) ...[
                            Positioned(
                              left: 0,
                              bottom: 300.h,
                              child: Image.asset(
                                AppImages.bear,
                                scale: 4,
                              ),
                            )
                          ],
                          if (needPainterBoyImg) ...[
                            Positioned(
                              right: 0,
                              bottom: 200.h,
                              child: Image.asset(
                                AppImages.painter_boy,
                                scale: 4,
                              ),
                            )
                          ],
                          if (needPainterGirlImg) ...[
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Image.asset(
                                AppImages.painter_girl,
                                scale: 3,
                                height: 140.h,
                              ),
                            )
                          ],
                          if (needSingerBoy) ...[
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                AppImages.singer_boy,
                                scale: 3,
                                height: 220.h,
                              ),
                            )
                          ],
                          Padding(
                            padding: needCustomPadding
                                ? EdgeInsets.symmetric(
                                    horizontal: horizontalPadding ?? 32.w,
                                    vertical: verticalPadding ?? 15.h)
                                : EdgeInsets.zero,
                            child: body,
                          )
                        ])
                      : Padding(
                          padding: needCustomPadding
                              ? EdgeInsets.symmetric(
                                  horizontal: horizontalPadding ?? 32.w,
                                  vertical: verticalPadding ?? 15.h)
                              : EdgeInsets.zero,
                          child: body,
                        ),
        ),
      ],
    );
  }
}
