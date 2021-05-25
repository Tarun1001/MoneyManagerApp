import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HomeModel with ChangeNotifier {
 
  List _listfromDB = [];

  
  List get listfromDB => _listfromDB;

  Box dataBox;
  int _income = 1000;
  int get income => _income;

  int _totalcost = 0;
  int get totalcost => _totalcost;

  
  
}
