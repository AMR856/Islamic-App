import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/models/hadith_model.dart';
import 'package:islami_app/features/main_layout/hadith_tab/widgets/hadith_alone.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
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
                SizedBox(height: context.getHeight() * 40 / 932),
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
                                    Radius.circular(
                                      context.getWidth() * 20 / 430,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: context.getHeight() * 15 / 932,
                                    left: context.getWidth() * 9 / 430,
                                    right: context.getWidth() * 9 / 430,
                                    bottom: context.getHeight() * 30 / 932,
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
                                                fontSize:
                                                    context.getWidth() *
                                                    24 /
                                                    430,
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
                                      SizedBox(
                                        height: context.getHeight() * 12 / 932,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            hadith.content,
                                            style: TextStyle(
                                              fontFamily: 'Janna',
                                              fontSize:
                                                  context.getWidth() * 16 / 430,
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
                                    bottomLeft: Radius.circular(
                                      context.getWidth() * 20 / 430,
                                    ),
                                    bottomRight: Radius.circular(
                                      context.getWidth() * 20 / 430,
                                    ),
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
