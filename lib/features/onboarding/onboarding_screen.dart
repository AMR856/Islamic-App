import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/onboarding_assets.dart';
import 'package:islami_app/core/routes/routes_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.logo3x),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: OnBoardingAssets.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(OnBoardingAssets.images[index]),
                      SizedBox(height: index == 0 ? 60.h : 20.h),
                      Text(
                        OnBoardingAssets.mainTitleStrings[index],
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Janna',
                          color: ColorManager.gold,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        textAlign: TextAlign.center,
                        OnBoardingAssets.secondTitleString[index],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Janna',
                          color: ColorManager.gold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentIndex == 0
                    ? SizedBox(width: 60.w)
                    : TextButton(
                        onPressed: () {
                          if (_currentIndex == 0) {
                            return;
                          } else {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Janna',
                            color: ColorManager.gold,
                          ),
                        ),
                      ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: OnBoardingAssets.images.length,
                  effect: WormEffect(
                    dotHeight: 12.h,
                    dotWidth: 12.w,
                    activeDotColor: ColorManager.gold,
                    dotColor: ColorManager.lightGray,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentIndex == OnBoardingAssets.images.length - 1) {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesManager.mainLayout,
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == OnBoardingAssets.images.length - 1
                        ? 'Finish'
                        : 'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Janna',
                      color: ColorManager.gold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
