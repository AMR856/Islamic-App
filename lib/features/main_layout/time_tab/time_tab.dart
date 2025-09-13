import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetsManager.timeBackground,
            fit: BoxFit.cover,
          ),
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
                SizedBox(height: context.getHeight() * 15 / 932),

              ],
            ),
          ),
        ),
      ],
    );
  }

}
