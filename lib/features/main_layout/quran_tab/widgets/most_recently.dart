import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_app/core/models/sura_model.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/suras_manager.dart';
import 'package:islami_app/core/routes/routes_manager.dart';

class MostRecently extends StatefulWidget {
  const MostRecently({super.key});

  @override
  State<MostRecently> createState() => MostRecentlyState();
}

class MostRecentlyState extends State<MostRecently> {
  late List<SuraModel>? suras = [];

  void updateSuras(List<SuraModel> newSuras) {
    setState(() {
      suras = newSuras;
      saveData();
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? surasIndices = prefs.getStringList('most-recent-array');
    if (surasIndices != null) {
      final suras = surasIndices.map((elm) {
        final index = int.parse(elm);
        return SuraModel(
          SurasManager.arabicQuranSuras[index],
          SurasManager.englishQuranSurahs[index],
          int.parse(SurasManager.versesCount[index]),
          index,
        );
      }).toList();
      updateSuras(suras.reversed.toList());
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'most-recent-array',
      suras!.map((elm) => elm.index.toString()).toList(),
    );
  }

  Future<void> cleanData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    updateSuras([]);
  }

  Future<void> deleteData(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> surasIndices = prefs.getStringList('most-recent-array') ?? [];
    surasIndices.remove(index.toString());
    await prefs.setStringList('most-recent-array', surasIndices);
    final newSuras = surasIndices.map((elm) {
      final i = int.parse(elm);
      return SuraModel(
        SurasManager.arabicQuranSuras[i],
        SurasManager.englishQuranSurahs[i],
        int.parse(SurasManager.versesCount[i]),
        i,
      );
    }).toList();

    updateSuras(newSuras);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (suras == null || suras!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  'Most Recently',
                  style: TextStyle(
                    fontFamily: 'Janna',
                    color: ColorManager.white,
                    fontSize: 16.sp,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cleanData();
                  },
                  child: Text(
                    'Clear Cache',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      color: ColorManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 150.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: suras!.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.suraDetails,
                      arguments: SuraModel(
                        suras![index].nameAr,
                        suras![index].nameEn,
                        suras![index].versesCount,
                        suras![index].index,
                        key: widget.key as GlobalKey<MostRecentlyState>,
                      ),
                    );
                  },
                  onDoubleTap: () {
                    deleteData(index);
                  },
                  child: Container(
                    height: 150.h,
                    width: 283.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorManager.gold,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 17.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      suras![index].nameEn,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontFamily: 'Janna',
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    Text(
                                      suras![index].nameAr,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontFamily: 'Janna',
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      child: Text(
                                        '${suras![index].versesCount} Verses',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'Janna',
                                          color: ColorManager.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 120.h,
                                width: 140.w,
                                child: Image.asset(
                                  AssetsManager.readingImage,
                                  color: ColorManager.black,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
