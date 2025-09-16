import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:http/http.dart' as http;
import 'package:islami_app/core/resources/urls_manager.dart';
import 'package:islami_app/core/resources/week_days.dart';
import 'package:islami_app/core/resources/months.dart';
import 'package:islami_app/features/main_layout/time_tab/widgets/azkar_widget.dart';
import 'package:islami_app/features/main_layout/time_tab/widgets/prayers_carousel.dart';
import 'package:islami_app/features/main_layout/time_tab/widgets/prayers_widget_bottom.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});
  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  List<String> salahTimings = [];

  List<String> salahs = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  DateTime now = DateTime.now();
  String? hijriDate;
  String? hijriDay;
  String? hijriMonth;
  String? hijriYear;

  Future<void> fetchData() async {
    try {
      String url = URLsManager.prayTimeURL;
      url +=
          '${now.day}-${now.month}-${now.year}?city=alexandria&country=egypt';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        final salahTimingsObject = data['timings'];

        hijriDate = data['date']['hijri']['date'];
        hijriDay = hijriDate!.split('-')[0];
        hijriMonth = Months.monthsHijri[int.parse(hijriDate!.split('-')[1])]!;
        hijriYear = hijriDate!.split('-')[2];

        salahTimings.clear();
        for (String salah in salahs) {
          salahTimings.add(salahTimingsObject[salah]);
        }
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error fetching prayer times: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsManager.timeBackground, fit: BoxFit.cover),
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
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(AssetsManager.logo3x)),
                    SizedBox(height: 15.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: ColorManager.gold,
                      ),
                      width: double.infinity,
                      height: 301.h,
                      child:
                          (hijriDay == null ||
                              hijriMonth == null ||
                              hijriYear == null)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.black,
                              ),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 26.w,
                                    vertical: 16.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${now.day} ${Months.monthsEnglish[now.month]},\n${now.year}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: ColorManager.black.withValues(
                                            alpha: 0.71,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Janna',
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Pray Time',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: ColorManager.black
                                                  .withValues(alpha: 0.71),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Janna',
                                            ),
                                          ),
                                          Text(
                                            WeekDays.weekDay[now.weekday] ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: ColorManager.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Janna',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '$hijriDay $hijriMonth,\n$hijriYear',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: ColorManager.black.withValues(
                                            alpha: 0.71,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Janna',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PrayersCarousel(
                                  salahTimings: salahTimings,
                                  salahs: salahs,
                                ),
                                Spacer(),
                                PrayersWidgetBottom(
                                  now: now,
                                  salahTimings: salahTimings,
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Azkar',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                        fontFamily: 'Janna',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AzkarWidget(
                              imageName: AssetsManager.eveningBackground,
                              azkarName: 'Evening Azkar', azkarType: 'أذكار المساء',
                            ),
                            AzkarWidget(
                              imageName: AssetsManager.morningBackground,
                              azkarName: 'Morning Azkar', azkarType: 'أذكار الصباح',
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AzkarWidget(
                              imageName: AssetsManager.wakingBackground,
                              azkarName: 'Waking Azkar', azkarType: 'أذكار الاستيقاظ',
                            ),
                            AzkarWidget(
                              imageName: AssetsManager.sleepingBackground,
                              azkarName: 'Sleeping Azkar', azkarType: 'أذكار النوم',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
