import 'package:flutter/material.dart';
import 'package:moneymanager/constants/colors.dart';
import 'package:moneymanager/views/Profile_screen/profile_screen.dart';
import 'package:moneymanager/views/category%20Screen/category_screen.dart';
import 'package:moneymanager/views/statistics_screen/statistics_screen.dart';

import 'package:moneymanager/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void ontap(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void onpagechanged(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  int _currentIndex = 0;

  final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MoneyManager",
          style: TextStyle(color: constantColors.bgcolor),
        ),
        backgroundColor: constantColors.blueaccentcolor,
      ),
      backgroundColor: constantColors.bgcolor,
      body: IndexedStack(
        children: [
          CategoryScreen(),
          StatisticsScreen(),
          ProfileScreen(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: bottomAppBar(_currentIndex, ontap),
    );
  }
}
