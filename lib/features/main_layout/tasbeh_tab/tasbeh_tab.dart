import 'package:flutter/material.dart';
import 'dart:math';
import 'package:islami_app/core/extensions/context_size.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';

class TasbehTab extends StatefulWidget {
  final List<String> azkar = [
    'سبحان الله',
    ' الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله',
  ];
  int _currentIndex = 0;
  int _currentCount = 0;
  TasbehTab({super.key});

  @override
  State<TasbehTab> createState() => _TasbehTabState();
}

class _TasbehTabState extends State<TasbehTab> {
  double _angle = 0;

  void _rotate() {
    setState(() {
      _angle += (2 * pi) / 33;
      widget._currentCount += 1;
      if (widget._currentCount == 33 ||
          widget._currentCount == 1 && widget._currentIndex == 4) {
        if (widget._currentIndex == widget.azkar.length - 1) {
          widget._currentIndex = 0;
        } else {
          widget._currentIndex++;
        }
        widget._currentCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetsManager.tasbehBackground3x,
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(AssetsManager.logo3x),
                Padding(
                  padding: EdgeInsets.all(context.getWidth() * 25 / 430),
                  child: Text(
                    'سَبِّحِ اسْمَ رَبِّكَ الأعلى',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      fontSize: context.getWidth() * 38 / 430,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                // sebha + text
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(AssetsManager.sebhaHead),
                      ),
                      Center(
                        child: InkWell(
                          onTap: _rotate,
                          child: AnimatedRotation(
                            turns: _angle / (2 * pi),
                            duration: const Duration(milliseconds: 150),
                            child: Image.asset(AssetsManager.sebha),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.azkar[widget._currentIndex],
                              style: TextStyle(
                                fontSize: widget._currentIndex == 4
                                    ? context.getWidth() * 28 / 430
                                    : context.getWidth() * 36 / 430,
                                color: ColorManager.white,
                                fontFamily: 'Janna',
                              ),
                            ),
                            SizedBox(height: context.getHeight() * 20 / 932),
                            Text(
                              '${widget._currentCount}',
                              style: TextStyle(
                                fontSize: context.getWidth() * 36 / 430,
                                color: ColorManager.white,
                                fontFamily: 'Janna',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
