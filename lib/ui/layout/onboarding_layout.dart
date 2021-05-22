import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/global/color.dart';

class OnBoardingLayout extends StatefulWidget {
  final String image;
  final String title;
  final String desc;
  final length;
  final index;

  const OnBoardingLayout(
      {Key? key,
      required this.image,
      required this.title,
      required this.desc,
      this.length,
      this.index})
      : super(key: key);

  @override
  _OnBoardingLayoutState createState() => _OnBoardingLayoutState();
}

class _OnBoardingLayoutState extends State<OnBoardingLayout> {
  ScreenUtil screenUtil = new ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Positioned(
              top: screenUtil.setHeight(80),
              bottom: screenUtil.setHeight(357),
              left: 0,
              right: 0,
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: screenUtil.setHeight(527),
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenUtil.setWidth(16),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.desc,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  pageIndicator(bool index) {
    return index ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        height: screenUtil.setHeight(12),
        width: screenUtil.setWidth(34),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ThemeColors.primaryColorLight,
        ),
      ),
    ) : Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        height: screenUtil.setWidth(12),
        width: screenUtil.setWidth(12),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
