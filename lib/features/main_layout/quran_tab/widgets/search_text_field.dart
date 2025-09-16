import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/icon_manager.dart';

class SearchTextField extends StatelessWidget {
  final Function(String) onSearch;
  const SearchTextField({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String text) {
        onSearch(text);
      },
      style: TextStyle(
        fontFamily: 'Janna',
        color: ColorManager.white,
        fontSize: 16.sp,
      ),
      cursorColor: ColorManager.white,
      decoration: InputDecoration(
        hintText: 'Sura Name',
        hintStyle: TextStyle(
          fontFamily: 'Janna',
          color: ColorManager.white,
          fontSize: 16.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(color: ColorManager.gold, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(color: ColorManager.gold, width: 1.w),
        ),
        prefixIcon: Image.asset(IconManager.quran3x, color: ColorManager.gold),
      ),
    );
  }
}
