import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/resources/assets_manager.dart';
import 'package:islami_app/core/resources/colors_manager.dart';
import 'package:islami_app/features/main_layout/time_tab/widgets/azkar_details.dart';

class AzkarWidget extends StatefulWidget {
  final String imageName;
  final String azkarName;
  final String azkarType;
  const AzkarWidget({
    super.key,
    required this.imageName,
    required this.azkarName,
    required this.azkarType,
  });

  @override
  State<AzkarWidget> createState() => _AzkarWidgetState();
}

class _AzkarWidgetState extends State<AzkarWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AzkarDetails(azkarType: widget.azkarType),
          ),
        );
      },
      child: Container(
        width: 185.w,
        height: 259.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorManager.gold),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 29.h),
              child: Image.asset(widget.imageName),
            ),
            Text(
              widget.azkarName,
              style: TextStyle(
                fontSize: 20.sp,
                color: ColorManager.white,
                fontFamily: 'Janna',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
