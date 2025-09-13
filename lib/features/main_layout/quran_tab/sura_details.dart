import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import '../../../core/models/sura_model.dart';

class SuraDetails extends StatefulWidget {
  const SuraDetails({super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  late SuraModel suraModel;
  final String basePath = 'assets/suras';
  late String suraContent;
  late List<String> suraContentLinesRemoved = [];
  int? currentSelectedSura;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    suraModel = ModalRoute.of(context)!.settings.arguments as SuraModel;
    readSura();
  }

  Future<void> readSura() async {
    suraContent = await rootBundle.loadString(
      '$basePath/${suraModel.index + 1}.txt',
    );
    suraContentLinesRemoved = suraContent.trim().split('\n');
    setState(() {});
  }

  // 430 * 932
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            List<SuraModel>? suras = suraModel.key?.currentState!.suras;
            for (int i = 0; i < suras!.length; i++){
              if (suras[i].nameEn == suraModel.nameEn) {
                Navigator.pop(context);
                return;
              }
            }
            suras.add(suraModel);
            suras = suras.reversed.toList();
            suraModel.key?.currentState!.updateSuras(suras);
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getWidth() * 32 / 430,
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              size: context.getWidth() * 30 / 432,
            ),
          ),
        ),
        foregroundColor: ColorManager.gold,
        backgroundColor: ColorManager.black,
        title: Center(
          child: Text(
            suraModel.nameEn,
            style: TextStyle(
              fontSize: context.getWidth() * 20 / 430,
              fontFamily: 'Janna',
            ),
          ),
        ),
      ),
      backgroundColor: ColorManager.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Image.asset(AssetsManager.rightCorner),
              ),
              Text(
                suraModel.nameAr,
                style: TextStyle(
                  fontFamily: 'Janna',
                  fontSize: context.getWidth() * 24 / 430,
                  color: ColorManager.gold,
                ),
              ),
              Image.asset(AssetsManager.rightCorner),
            ],
          ),
          SizedBox(height: context.getHeight() * 25 / 932),
          suraContentLinesRemoved.isEmpty
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.gold),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => currentSelectedSura = index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              context.getWidth() * 15 / 432,
                            ),
                            border: Border.all(color: ColorManager.gold),
                            color: currentSelectedSura == null
                                ? ColorManager.black
                                : (currentSelectedSura == index)
                                ? ColorManager.gold
                                : ColorManager.black,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: context.getHeight() * 10 / 932,
                            horizontal: context.getWidth() * 10 / 432,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: context.getWidth() * 20 / 432,
                          ),
                          child: Text(
                            '[${index + 1}] ${suraContentLinesRemoved[index]}',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: context.getWidth() * 20 / 432,
                              color: currentSelectedSura == null
                                  ? ColorManager.gold
                                  : (currentSelectedSura == index)
                                  ? ColorManager.black
                                  : ColorManager.gold,
                              fontFamily: 'Janna',
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: context.getHeight() * 20 / 932),
                    itemCount: suraContentLinesRemoved.length,
                  ),
                ),
          SizedBox(height: context.getHeight() * 20 / 932),
          Opacity(
            opacity: 0.6,
            child: Image.asset(AssetsManager.mosqueDecoration),
          ),
        ],
      ),
    );
  }
}
