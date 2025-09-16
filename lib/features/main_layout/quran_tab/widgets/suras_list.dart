import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              horizontal: 15.h,
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
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filteredSuras[index].nameEn,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Janna',
                          color: ColorManager.white,
                        ),
                      ),
                      Text(
                        '${filteredSuras[index].versesCount} Verses',
                        style: TextStyle(
                          fontSize: 14.sp,
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
                      fontSize: 20.sp,
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
          indent: 64.w,
          endIndent: 64.w,
        ),
        itemCount: filteredSuras.length,
      ),
    );
  }
}
