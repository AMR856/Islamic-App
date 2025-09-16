import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/resources/colors_manager.dart';
import 'core/routes/routes_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(IslamiApp());
}

class IslamiApp extends StatefulWidget {
  const IslamiApp({super.key});

  @override
  State<IslamiApp> createState() => _IslamiAppState();
}

class _IslamiAppState extends State<IslamiApp> {
  String? firstRoute;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? isFirstTime = prefs.getString('is-first-time');

    if (isFirstTime == null) {
      await prefs.setString('is-first-time', 'some-value');
      setState(() {
        firstRoute = RoutesManager.onBoarding;
      });
    } else {
      setState(() {
        firstRoute = RoutesManager.mainLayout;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (firstRoute == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: ColorManager.black,
          body: Center(child: CircularProgressIndicator(color: ColorManager.gold, strokeWidth: 5,)),
        ),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RoutesManager.routes,
        initialRoute: firstRoute,
      ),
    );
  }
}
