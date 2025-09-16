import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/colors_manager.dart';
import '../utils/convert_time.dart';

class PrayersCarousel extends StatelessWidget {
  final List<String> salahTimings;
  final List<String> salahs;
  const PrayersCarousel({
    super.key,
    required this.salahTimings,
    required this.salahs,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: salahs.asMap().entries.map((entry) {
        int index = entry.key;
        String salah = entry.value;
        String time = salahTimings.isNotEmpty ? salahTimings[index] : '--:--';
        bool isAM = (index <= 1);
        return Container(
          width: 104.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              colors: [ColorManager.black, ColorManager.lightBrown],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    salah,
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      convertToAmPm(time),
                      style: TextStyle(
                        fontFamily: 'Janna',
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                        fontSize: 32.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    isAM ? 'AM' : 'PM',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 128.h,
        viewportFraction: 0.3,
      ),
    );
  }
}
