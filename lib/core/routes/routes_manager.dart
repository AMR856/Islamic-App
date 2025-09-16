import 'package:flutter/material.dart';
import 'package:islami_app/features/main_layout/main_layout.dart';
import 'package:islami_app/features/main_layout/quran_tab/sura_details.dart';
import 'package:islami_app/features/onboarding/onboarding_screen.dart';

abstract class RoutesManager {
  static final String mainLayout = 'MainLayout';
  static final String suraDetails = 'SuraDetailsScreen';
  static final String onBoarding = 'OnBoardingScreen';
  static final Map<String, Widget Function(BuildContext)> routes = {
    mainLayout: (context) => MainLayout(),
    suraDetails: (context) => SuraDetails(),
    onBoarding: (context) => OnboardingScreen()
  };
}
