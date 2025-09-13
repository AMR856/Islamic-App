import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/sura_model.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/suras_manager.dart';
import '../../../../core/routes/routes_manager.dart';

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
    cleanData();
    // loadData();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight() * 150 / 932,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.getWidth() * 20 / 432,
          vertical: context.getHeight() * 10 / 932,
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: suras!.length,
          separatorBuilder: (context, index) =>
              SizedBox(width: context.getWidth() * 10 / 432),
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
                height: context.getHeight() * 150 / 932,
                width: context.getWidth() * 283 / 432,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorManager.gold,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.getHeight() * 12 / 932,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.getWidth() * 17 / 432,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  suras![index].nameEn,
                                  style: TextStyle(
                                    fontSize: context.getWidth() * 24 / 432,
                                    fontFamily: 'Janna',
                                    color: ColorManager.black,
                                  ),
                                ),
                                Text(
                                  suras![index].nameAr,
                                  style: TextStyle(
                                    fontSize: context.getWidth() * 24 / 432,
                                    fontFamily: 'Janna',
                                    color: ColorManager.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.getHeight() * 8 / 932,
                                  ),
                                  child: Text(
                                    '${suras![index].versesCount} Verses',
                                    style: TextStyle(
                                      fontSize: context.getWidth() * 14 / 432,
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
                            height: context.getHeight() * 110 / 932,
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
    );
  }
}
