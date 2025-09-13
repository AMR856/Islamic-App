import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/icon_manager.dart';
import '../../../../core/resources/radio_reciters_list.dart';

class RadioElement extends StatefulWidget {
  final int index;
  final bool isRadio;
  final bool isPlaying;
  final Future<void> Function(int index) togglePlay;
  const RadioElement({
    super.key,
    required this.index,
    required this.isRadio,
    required this.togglePlay, required this.isPlaying,
  });

  @override
  State<RadioElement> createState() => _RadioElementState();
}

class _RadioElementState extends State<RadioElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.getHeight() * 141 / 932,
      decoration: BoxDecoration(
        color: ColorManager.gold,
        borderRadius: BorderRadius.circular(context.getWidth() * 17 / 430),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: context.getHeight() * 12 / 932),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(AssetsManager.mosqueDecoration),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.isRadio
                      ? 'Radio ${RadioReciters.radioList[widget.index]}'
                      : RadioReciters.recitersList[widget.index],
                  style: TextStyle(
                    fontSize: context.getWidth() * 20 / 432,
                    fontFamily: 'Janna',
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: context.getHeight() * 30 / 932),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.togglePlay(widget.index);
                      },
                      child: Icon(
                        widget.isPlaying ? Icons.pause : Icons.play_arrow_rounded  ,
                        size: context.getWidth() * 70 / 430,
                      ),
                    ),
                    SizedBox(width: context.getWidth() * 20 / 430),
                    ImageIcon(
                      AssetImage(IconManager.volumeUpIcon),
                      size: context.getWidth() * 40 / 430,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
