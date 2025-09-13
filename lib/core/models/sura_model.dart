import 'package:flutter/material.dart';
import 'package:islami_app/features/main_layout/quran_tab/widgets/most_recently.dart';

class SuraModel {
  String nameAr;
  String nameEn;
  int versesCount;
  int index;
  GlobalKey<MostRecentlyState>? key;
  SuraModel(this.nameAr, this.nameEn, this.versesCount, this.index, {
    this.key
  });
}
