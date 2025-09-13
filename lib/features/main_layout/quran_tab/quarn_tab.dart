import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/suras_manager.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/most_recently.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/search_text_field.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/suras_list.dart';
import '../../../core/models/sura_model.dart';
import '../../../core/resources/colors_manager.dart';

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
                  ColorManager.black.withOpacity(0.7),
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
              vertical: context.getHeight() * 30 / 932,
            ),
            child: Column(
              children: [
                Image.asset(AssetsManager.logo3x),
                Padding(
                  padding: EdgeInsets.all(context.getWidth() * 20 / 430),
                  child: SearchTextField(onSearch: onSearch),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.getHeight() * 15 / 932,
                    horizontal: context.getWidth() * 21 / 432,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Most Recently',
                      style: TextStyle(
                        fontFamily: 'Janna',
                        color: ColorManager.white,
                        fontSize: context.getWidth() * 16 / 432,
                      ),
                    ),
                  ),
                ),
                MostRecently(key: mostRecentlyKey),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.getHeight() * 10 / 932,
                    horizontal: context.getWidth() * 21 / 432,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Suras List',
                      style: TextStyle(
                        fontFamily: 'Janna',
                        color: ColorManager.white,
                        fontSize: context.getWidth() * 16 / 432,
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
