import 'package:flutter/material.dart';
import 'package:islami_app/core/extensions/context_size.dart';
import 'package:islami_app/core/models/hadith_model.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class HadithAlone extends StatefulWidget {
  final HadithModel hadithModel;
  const HadithAlone({super.key, required this.hadithModel});

  @override
  State<HadithAlone> createState() => _HadithAloneState();
}

class _HadithAloneState extends State<HadithAlone> {
  // 430 * 932
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getWidth() * 32 / 430,
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              size: context.getWidth() * 30 / 432,
            ),
          ),
        ),
        foregroundColor: ColorManager.gold,
        backgroundColor: ColorManager.black,
        title: Center(
          child: Text(
            '${widget.hadithModel.index + 1} Hadith',
            style: TextStyle(
              fontSize: context.getWidth() * 20 / 430,
              fontFamily: 'Janna',
            ),
          ),
        ),
      ),
      backgroundColor: ColorManager.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Image.asset(AssetsManager.rightCorner),
              ),
              Expanded(
                child: Text(
                  widget.hadithModel.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Janna',
                    fontSize: context.getWidth() * 24 / 430,
                    color: ColorManager.gold,
                  ),
                ),
              ),
              Image.asset(AssetsManager.rightCorner),
            ],
          ),
          SizedBox(height: context.getHeight() * 25 / 932),
          widget.hadithModel.content.isEmpty
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.gold),
                  ),
                )
              : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        context.getWidth() * 15 / 432,
                      ),
                      border: Border.all(color: ColorManager.gold),
                      color: ColorManager.black,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: context.getHeight() * 10 / 932,
                      horizontal: context.getWidth() * 10 / 432,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.getWidth() * 20 / 432,
                    ),
                    child: Text(
                      widget.hadithModel.content,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.getWidth() * 20 / 432,
                        color: ColorManager.gold,
                        fontFamily: 'Janna',
                      ),
                    ),
                  ),
                ),
          SizedBox(height: context.getHeight() * 20 / 932),
          Opacity(
            opacity: 0.6,
            child: Image.asset(AssetsManager.mosqueDecoration),
          ),
        ],
      ),
    );
  }
}
