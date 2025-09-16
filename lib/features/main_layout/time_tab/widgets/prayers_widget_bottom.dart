import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/icon_manager.dart';
import 'package:islami_app/features/main_layout/time_tab/utils/next_prayer.dart';

class PrayersWidgetBottom extends StatelessWidget {
  final DateTime now;
  final List<String> salahTimings;
  const PrayersWidgetBottom({
    super.key,
    required this.now,
    required this.salahTimings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 34.w),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next Pray ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorManager.black.withValues(alpha: 0.71),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Janna',
                  ),
                ),
                Text(
                  '- ${nextPrayerTime(now, salahTimings)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorManager.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Janna',
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: ImageIcon(AssetImage(IconManager.volumeOffIcon)),
          ),
        ],
      ),
    );
  }
}
