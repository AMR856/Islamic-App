import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/suras_manager.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/most_recently.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/search_text_field.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/suras_list.dart';
import 'package:islami_app/core/models/sura_model.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<SuraModel> filteredSuras = [];
  late GlobalKey<MostRecentlyState> mostRecentlyKey;

  @override
  void initState() {
    super.initState();
    filteredSuras = SurasManager.allSuras();
    mostRecentlyKey = GlobalKey<MostRecentlyState>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetsManager.quranBackground3x,
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
              children: [
                Image.asset(AssetsManager.logo3x),
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: SearchTextField(onSearch: onSearch),
                ),
                MostRecently(key: mostRecentlyKey),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 21.w,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Suras List',
                      style: TextStyle(
                        fontFamily: 'Janna',
                        color: ColorManager.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SurasList(
                  filteredSuras: filteredSuras,
                  mostRecentlyKey: mostRecentlyKey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onSearch(String text) {
    setState(() {
      if (text.isEmpty) {
        filteredSuras = SurasManager.suras;
      } else {
        filteredSuras = SurasManager.suras.where((sura) {
          return sura.nameEn.toLowerCase().contains(text.toLowerCase()) ||
              sura.nameAr.contains(text);
        }).toList();
      }
    });
  }
}
