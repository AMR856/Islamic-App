import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/core/resources/icon_manager.dart';
import 'package:islami_app/core/resources/radio_reciters_list.dart';

class RadioElement extends StatefulWidget {
  final int index;
  final int? playingIndex;
  final bool isRadio;
  final bool isPlaying;
  final bool isMuted;
  final Future<void> Function(int index) togglePlay;
  final Future<void> Function() toggleMute;

  const RadioElement({
    super.key,
    required this.index,
    required this.isRadio,
    required this.togglePlay,
    required this.isPlaying,
    required this.isMuted,
    required this.toggleMute,
    required this.playingIndex,
  });

  @override
  State<RadioElement> createState() => _RadioElementState();
}

class _RadioElementState extends State<RadioElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: ColorManager.gold,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 2.h),
              child: Opacity(
                opacity: widget.isPlaying ? 0.4 : 1.0,
                child: Image.asset(
                  widget.isPlaying
                      ? AssetsManager.soundWave
                      : AssetsManager.mosqueDecoration,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: widget.isPlaying ? 100.h : 130.h,
                ),
              ),
            ),

            // Foreground content
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.isRadio
                      ? 'Radio ${RadioReciters.radioList[widget.index]}'
                      : RadioReciters.recitersList[widget.index],
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: 'Janna',
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          widget.togglePlay(widget.index);
                        },
                        child: Icon(
                          widget.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          size: 70.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    InkWell(
                      onTap: () {
                        widget.toggleMute();
                      },
                      child: ImageIcon(
                        AssetImage(
                          widget.isMuted && widget.playingIndex == widget.index
                              ? IconManager.volumeOffIcon
                              : IconManager.volumeUpIcon,
                        ),
                        size: 40.sp,
                      ),
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
