import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:islami_app/core/resources/urls_manager.dart';
import 'package:islami_app/features/main_layout/radio_tab/widgets/radio_element.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/radio_reciters_list.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  bool isRadio = true;
  final AudioPlayer _player = AudioPlayer();
  List<String> radioURLs = [];
  int? playingIndex;
  bool isMuted = false;

  Future<void> _togglePlay(int index) async {
    if (playingIndex == index) {
      await _player.stop();
      setState(() {
        playingIndex = null;
      });
    } else {
      await _player.stop();
      await _player.play(UrlSource(radioURLs[index]));
      setState(() {
        playingIndex = index;
      });
    }
  }

  Future<void> _toggleMute() async {
    if (isMuted) {
      await _player.setVolume(1.0);
    } else {
      await _player.setVolume(0.0);
    }
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(URLsManager.radioURL));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final radioData = data['radios'];

        radioURLs.clear();
        for (int i = 0; i < RadioReciters.radioArabicNames.length; i++) {
          for (int j = 0; j < radioData.length; j++) {
            if (RadioReciters.radioArabicNames[i] ==
                radioData[j]['name'].trim()) {
              radioURLs.add(radioData[j]['url']);
              break;
            }
          }
        }
        setState(() {});
      }
    } catch (e) {
      // TODO: lol
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetsManager.radioBackground3x,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.black,
                  ColorManager.black.withValues(alpha: 0.7),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Column(
              children: [
                Image.asset(AssetsManager.logo3x),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          isRadio = true;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isRadio
                                ? ColorManager.gold
                                : ColorManager.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(17.sp),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: Text(
                            'Radio',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isRadio
                                  ? ColorManager.black
                                  : ColorManager.white,
                              fontSize: 20.sp,
                              fontFamily: 'Janna',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          isRadio = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isRadio
                                ? ColorManager.black.withValues(alpha: 0.7)
                                : ColorManager.gold,
                            borderRadius: BorderRadius.circular(17.sp),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: Text(
                            'Reciters',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isRadio
                                  ? ColorManager.white
                                  : ColorManager.black,
                              fontSize: 20.sp,
                              fontFamily: 'Janna',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: radioURLs.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) => RadioElement(
                              index: index,
                              isRadio: isRadio,
                              isPlaying: index == playingIndex,
                              playingIndex: playingIndex,
                              togglePlay: _togglePlay,
                              isMuted: isMuted,
                              toggleMute: _toggleMute,
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15.h),
                            itemCount: radioURLs.length,
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.gold,
                            ),
                          ),
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
