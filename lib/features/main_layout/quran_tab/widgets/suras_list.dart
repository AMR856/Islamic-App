import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/routes/routes_manager.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/most_recently.dart';
import 'package:islami_app/core/models/sura_model.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class SurasList extends StatelessWidget {
  final List<SuraModel> filteredSuras;
  final GlobalKey<MostRecentlyState> mostRecentlyKey;
  const SurasList({
    super.key,
    required this.filteredSuras,
    required this.mostRecentlyKey,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getWidth() * 15 / 432,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesManager.suraDetails,
                  arguments: SuraModel(
                    filteredSuras[index].nameAr,
                    filteredSuras[index].nameEn,
                    filteredSuras[index].versesCount,
                    index,
                    key: mostRecentlyKey,
                  ),
                );
              },
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsManager.suraVectorShape),
                      Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontFamily: 'Janna',
                          color: ColorManager.white,
                          fontSize: context.getWidth() * 20 / 432,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: context.getWidth() * 24 / 432),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filteredSuras[index].nameEn,
                        style: TextStyle(
                          fontSize: context.getWidth() * 20 / 432,
                          fontFamily: 'Janna',
                          color: ColorManager.white,
                        ),
                      ),
                      Text(
                        '${filteredSuras[index].versesCount}',
                        style: TextStyle(
                          fontSize: context.getWidth() * 14 / 432,
                          fontFamily: 'Janna',
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    filteredSuras[index].nameAr,
                    style: TextStyle(
                      fontSize: context.getWidth() * 20 / 432,
                      fontFamily: 'Janna',
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          indent: context.getWidth() * 64 / 432,
          endIndent: context.getWidth() * 64 / 432,
        ),
        itemCount: filteredSuras.length,
      ),
    );
  }
}
