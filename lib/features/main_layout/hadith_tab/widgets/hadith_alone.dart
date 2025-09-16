import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/models/hadith_model.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class HadithAlone extends StatefulWidget {
  final HadithModel hadithModel;
  const HadithAlone({super.key, required this.hadithModel});

  @override
  State<HadithAlone> createState() => _HadithAloneState();
}

class _HadithAloneState extends State<HadithAlone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Icon(Icons.arrow_back_rounded, size: 30.sp),
          ),
        ),
        foregroundColor: ColorManager.gold,
        backgroundColor: ColorManager.black,
        title: Center(
          child: Text(
            '${widget.hadithModel.index + 1} Hadith',
            style: TextStyle(fontSize: 20.sp, fontFamily: 'Janna'),
          ),
        ),
        actions: [SizedBox(width: 32.w + 30.sp)],
      ),
      backgroundColor: ColorManager.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Image.asset(AssetsManager.rightCorner),
                ),
                Expanded(
                  child: Text(
                    widget.hadithModel.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontSize: 24.sp,
                      color: ColorManager.gold,
                    ),
                  ),
                ),
                Image.asset(AssetsManager.rightCorner),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          widget.hadithModel.content.isEmpty
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.gold),
                  ),
                )
              : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: ColorManager.gold),
                      color: ColorManager.black,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      widget.hadithModel.content,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: ColorManager.gold,
                        fontFamily: 'Janna',
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 20.h),
          Opacity(
            opacity: 0.6,
            child: Image.asset(AssetsManager.mosqueDecoration),
          ),
        ],
      ),
    );
  }
}
