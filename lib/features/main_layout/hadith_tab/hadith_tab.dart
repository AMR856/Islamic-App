import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/models/hadith_model.dart';
import 'package:islami_app/features/main_layout/hadith_tab/widgets/hadith_alone.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HadithTab extends StatefulWidget {
  final int hadithIndex;
  const HadithTab({super.key, this.hadithIndex = 0});

  @override
  State<HadithTab> createState() => _HadithTabState();
}

class _HadithTabState extends State<HadithTab> {
  final String basePath = 'assets/hadith';
  List<HadithModel> hadithList = [];

  Future<void> readAllhadith() async {
    for (int i = 0; i < 50; i++) {
      String fileContent = await rootBundle.loadString(
        '$basePath/h${i + 1}.txt',
      );
      List<String> lines = fileContent.trim().split('\n');
      String name = lines[0];
      String content = lines.sublist(1).join('\n');

      hadithList.add(HadithModel(name: name, content: content, index: i));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readAllhadith();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsManager.hadithBackground, fit: BoxFit.cover),
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
              children: [
                Image.asset(AssetsManager.logo3x),
                SizedBox(height: 50.h),
                if (hadithList.isEmpty)
                  CircularProgressIndicator(color: ColorManager.gold)
                else
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: double.infinity,
                      ),
                      items: hadithList.map((hadith) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HadithAlone(hadithModel: hadith),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.gold,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.h,
                                    left: 9.w,
                                    right: 9.w,
                                    bottom: 30.h,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Image.asset(
                                              AssetsManager.rightCorner,
                                              color: ColorManager.black,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              hadith.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Janna',
                                                fontSize: 24.sp,
                                                color: ColorManager.black,
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            AssetsManager.rightCorner,
                                            color: ColorManager.black,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            hadith.content,
                                            style: TextStyle(
                                              fontFamily: 'Janna',
                                              fontSize: 16.sp,
                                              color: ColorManager.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Opacity(
                                  opacity: 0.25,
                                  child: Image.asset(
                                    AssetsManager.hadithWidgetBackground,
                                    color: ColorManager.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.sp),
                                    bottomRight: Radius.circular(20.sp),
                                  ),
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(
                                      AssetsManager.mosqueDecoration,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
