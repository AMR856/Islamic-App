import 'package:flutter/material.dart';
import 'core/routes/routes_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main(){
  runApp(IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RoutesManager.routes,
        initialRoute: RoutesManager.mainLayout,
      ),
    );
  }
}
