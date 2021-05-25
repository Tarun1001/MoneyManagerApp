import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/constants/constants.dart';

Widget bottomAppBar(int index, Function ontap) {
  ConstantColors constantColors = ConstantColors();
  return CustomNavigationBar(
    onTap: ontap,
    strokeColor: constantColors.boxcolor,
    scaleFactor: 0.2,
    scaleCurve: Curves.bounceInOut,
    bubbleCurve: Curves.bounceInOut,
    currentIndex: index,
    selectedColor: constantColors.blueaccentcolor,
    backgroundColor: constantColors.bgcolor,
    items: [
      CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
      CustomNavigationBarItem(icon: Icon(EvaIcons.bell)),
      CustomNavigationBarItem(icon: Icon(EvaIcons.settings)),
    ],
  );
}
