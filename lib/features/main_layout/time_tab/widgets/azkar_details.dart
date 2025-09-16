import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';

class AzkarDetails extends StatefulWidget {
  final String azkarType;
  const AzkarDetails({super.key, required this.azkarType});

  @override
  State<AzkarDetails> createState() => _AzkarDetailsState();
}

class _AzkarDetailsState extends State<AzkarDetails> {
  static const String azkarFile = 'assets/azkar.json';
  List<dynamic> azkar = [];
  int? currentSelectedzekr;
  List<String> allowedAzkar = [
    'أذكار الصباح',
    'أذكار المساء',
    'أذكار النوم',
    'أذكار الاستيقاظ'
  ];
  Future<void> readFile(String azkarType) async {
    if (!allowedAzkar.contains(azkarType)){
      Navigator.pop(context);
    }
    final contents = await rootBundle.loadString(azkarFile);
    Map<String, dynamic> data = json.decode(contents);
    try {
      azkar = data[azkarType];
      setState(() {

      });
    } catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFile(widget.azkarType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Icon(Icons.arrow_back_rounded, size: 30.sp),
          ),
        ),
        foregroundColor: ColorManager.gold,
        backgroundColor: ColorManager.black,
        title: Center(
          child: Text(
            widget.azkarType,
            style: TextStyle(fontSize: 20.sp, fontFamily: 'Janna'),
          ),
        ),
        actions: [SizedBox(width: 32.w + 30.sp)],
      ),
      backgroundColor: ColorManager.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Image.asset(AssetsManager.rightCorner),
                ),
                Image.asset(AssetsManager.rightCorner),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          azkar.isEmpty
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.gold),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => currentSelectedzekr = index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border.all(color: ColorManager.gold),
                            color: currentSelectedzekr == null
                                ? ColorManager.black
                                : (currentSelectedzekr == index)
                                ? ColorManager.gold
                                : ColorManager.black,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            '${azkar[index]['content']}\n عدد مرات التكرار: ${int.parse(azkar[index]['count'])} ',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: currentSelectedzekr == null
                                  ? ColorManager.gold
                                  : (currentSelectedzekr == index)
                                  ? ColorManager.black
                                  : ColorManager.gold,
                              fontFamily: 'Janna',
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemCount: azkar.length,
                  ),
                ),
          SizedBox(height: 20.h),
          Opacity(
            opacity: 0.6,
            child: Image.asset(AssetsManager.mosqueDecoration),
          ),
        ],
      ),
    );
  }
}
