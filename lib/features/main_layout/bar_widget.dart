import 'package:flutter/material.dart';
import '../../core/resources/colors_manager.dart';


class BarWidget extends StatelessWidget {
  final String iconName;
  final String iconLabel;
  const BarWidget({super.key, required this.iconName, required this.iconLabel});

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Image.asset(
        iconName,
      ),
      selectedIcon: Image.asset(
        iconName,
        color: ColorManager.white,
      ),
      label: iconLabel,
    );
  }
}
