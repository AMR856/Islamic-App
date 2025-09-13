import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';

import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/icon_manager.dart';

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
        fontSize: context.getWidth() * 16 / 432,
      ),
      cursorColor: ColorManager.white,
      decoration: InputDecoration(
        hintText: 'Sura Name',
        hintStyle: TextStyle(
          fontFamily: 'Janna',
          color: ColorManager.white,
          fontSize: context.getWidth() * 16 / 432,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: ColorManager.gold,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: ColorManager.gold,
            width: 1,
          ),
        ),
        prefixIcon: Image.asset(
          IconManager.quran3x,
          color: ColorManager.gold,
        ),
      ),
    );
  }
}
