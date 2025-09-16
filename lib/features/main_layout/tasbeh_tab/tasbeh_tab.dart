import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class TasbehTab extends StatefulWidget {
  final List<String> azkar = [
    'سبحان الله',
    ' الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله',
  ];
  int _currentIndex = 0;
  int _currentCount = 0;
  TasbehTab({super.key});

  @override
  State<TasbehTab> createState() => _TasbehTabState();
}

class _TasbehTabState extends State<TasbehTab> {
  double _angle = 0;

  void _rotate() {
    setState(() {
      _angle += (2 * pi) / 33;
      widget._currentCount += 1;
      if (widget._currentCount == 33 ||
          widget._currentCount == 1 && widget._currentIndex == 4) {
        if (widget._currentIndex == widget.azkar.length - 1) {
          widget._currentIndex = 0;
        } else {
          widget._currentIndex++;
        }
        widget._currentCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetsManager.tasbehBackground3x,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.black,
                  ColorManager.black.withValues(alpha: 0.7),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(AssetsManager.logo3x),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: Text(
                    'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontSize: 38.sp,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                // sebha + text
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(AssetsManager.sebhaHead),
                      ),
                      Center(
                        child: InkWell(
                          onTap: _rotate,
                          child: AnimatedRotation(
                            turns: _angle / (2 * pi),
                            duration: const Duration(milliseconds: 150),
                            child: Image.asset(AssetsManager.sebha),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.azkar[widget._currentIndex],
                              style: TextStyle(
                                fontSize: widget._currentIndex == 4
                                    ? 28.sp
                                    : 36.sp,
                                color: ColorManager.white,
                                fontFamily: 'Janna',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              '${widget._currentCount}',
                              style: TextStyle(
                                fontSize: 36.sp,
                                color: ColorManager.white,
                                fontFamily: 'Janna',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
