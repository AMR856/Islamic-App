import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/resources/urls_manager.dart';
import 'package:islami_app/features/main_layout/radio_tab/widgets/radio_element.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/radio_reciters_list.dart';

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
                                : ColorManager.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(
                              context.getWidth() * 17 / 430,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: context.getHeight() * 7 / 932,
                          ),
                          child: Text(
                            'Radio',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isRadio
                                  ? ColorManager.black
                                  : ColorManager.white,
                              fontSize: context.getWidth() * 20 / 430,
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
                                ? ColorManager.black.withOpacity(0.7)
                                : ColorManager.gold,
                            borderRadius: BorderRadius.circular(
                              context.getWidth() * 17 / 430,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: context.getHeight() * 7 / 932,
                          ),
                          child: Text(
                            'Reciters',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isRadio
                                  ? ColorManager.white
                                  : ColorManager.black,
                              fontSize: context.getWidth() * 20 / 430,
                              fontFamily: 'Janna',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.getHeight() * 8 / 932),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth() * 20 / 432,
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) => RadioElement(
                        index: index,
                        isRadio: isRadio,
                        isPlaying : index == playingIndex,
                        togglePlay: _togglePlay,
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.getHeight() * 12 / 932),
                      itemCount: radioURLs.length,
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
