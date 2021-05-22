import 'package:flutter/material.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/model/onboarding_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/ui/layout/custom_dialog.dart';
import 'package:wear_helmet/ui/layout/onboarding_layout.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingInfo> slides = [];
  int currentIndex = 0;
  ScreenUtil screenUtil = new ScreenUtil();
  PageController pageController = new PageController();

  @override
  void initState() {
    super.initState();
    getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: slides.length,
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return OnBoardingLayout(
                  image: slides[index].imageAsset,
                  title: slides[index].title,
                  desc: slides[index].description,
                  length: slides.length,
                  index: currentIndex,
                );
              },
            ),
            Positioned(
              top: screenUtil.setHeight(59),
              right: screenUtil.setWidth(24),
              child: GestureDetector(
                onTap: (){
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomDialogBox(
                          title: "Agreement",
                          descriptions: "By continuing you are agreeing to the terms and conditions.",
                          text: "Yes",
                          img: 'assets/images/onboarding/contract.png',
                        );
                      }
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: screenUtil.setWidth(31),
              bottom: screenUtil.setHeight(47),
              left: screenUtil.setWidth(26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        for (int i = 0; i < slides.length; i++)
                          i == currentIndex
                              ? pageIndicator(true)
                              : pageIndicator(false),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  Container(
                    child: slides.length-1 == currentIndex
                        ? Container(
                            child: ElevatedButton(
                              child: Text(
                                'Get started',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ThemeColors.white,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    ThemeColors.primaryColorLight),
                              ),
                              onPressed: () {
                                showDialog(context: context,
                                    builder: (BuildContext context){
                                      return CustomDialogBox(
                                        title: "Agreement",
                                        descriptions: "By continuing you are agreeing to the terms and conditions.",
                                        text: "Yes",
                                        img: 'assets/images/onboarding/contract.png',
                                      );
                                    }
                                );
                              },
                            ),
                          )
                        : Container(
                            child: IconButton(
                              color: ThemeColors.primaryColorLight,
                              icon: Icon(
                                Icons.arrow_forward,
                              ),
                              onPressed: () {
                                pageController.animateToPage(
                                  currentIndex + 1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  pageIndicator(bool index) {
    return index
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Container(
              height: screenUtil.setHeight(12),
              width: screenUtil.setWidth(34),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ThemeColors.primaryColorLight,
              ),
            ),
          )
        : Padding(
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

  void getSlides() {
    OnBoardingInfo first = OnBoardingInfo(
      'assets/images/onboarding/on_boarding.jpg',
      'Wear helmet and ride safe.',
      'Your ride, your helmet. Ride with your helmet and get rewards.',
      Container(
        width: ScreenUtil().setWidth(63),
        height: ScreenUtil().setWidth(63),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColors.primaryColorLight,
        ),
      ),
    );
    OnBoardingInfo second = OnBoardingInfo(
      'assets/images/onboarding/on_boarding_2.jpg',
      'Earn amazing rewards.',
      'Win amazing rewards just by wearing your helmet while riding.',
      Container(
        width: ScreenUtil().setWidth(63),
        height: ScreenUtil().setWidth(63),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColors.primaryColorLight,
        ),
      ),
    );
    OnBoardingInfo third = OnBoardingInfo(
      'assets/images/onboarding/on_boarding_3.jpg',
      'More travel, more rewards.',
      'The rewards you receive will be calculated based on the amount of distance you travel.',
      Container(
        width: ScreenUtil().setWidth(63),
        height: ScreenUtil().setWidth(63),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeColors.primaryColorLight,
        ),
      ),
    );

    slides.add(first);
    slides.add(second);
    slides.add(third);
  }
}
