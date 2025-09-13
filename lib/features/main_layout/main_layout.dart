import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/icon_manager.dart';
import 'package:islami_app/features/main_layout/bar_widget.dart';
import 'package:islami_app/features/main_layout/hadith_tab/hadith_tab.dart';
import 'package:islami_app/features/main_layout/quran_tab/quarn_tab.dart';
import 'package:islami_app/features/main_layout/radio_tab/radio_tab.dart';
import 'package:islami_app/features/main_layout/tasbeh_tab/tasbeh_tab.dart';
import 'package:islami_app/features/main_layout/time_tab/time_tab.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  List<Widget> tabs = [
    QuranTab(),
    HadithTab(),
    TasbehTab(),
    RadioTab(),
    TimeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: ColorManager.black.withOpacity(0.6),
        backgroundColor: ColorManager.gold,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            fontFamily: 'Janna',
            fontWeight: FontWeight.w700,
            color: ColorManager.white,
          ),
        ),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          BarWidget(iconName: IconManager.quran3x, iconLabel: 'Quran'),
          BarWidget(iconName: IconManager.hadith3x, iconLabel: 'Hadith'),
          BarWidget(iconName: IconManager.sebha3x, iconLabel: 'Tasbeh'),
          BarWidget(iconName: IconManager.radio3x, iconLabel: 'Radio'),
          BarWidget(iconName: IconManager.time3x, iconLabel: 'Time'),
        ],
      ),
    );
  }
}
