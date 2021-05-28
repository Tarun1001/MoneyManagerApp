import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/boxes.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';

class Dbservices with ChangeNotifier {
  void deleteData(int index) {
    final box = Boxes.getdata();
    box.deleteAt(index);
  }
//todo
  void editcategoty(
      {int index, Box box, String categorynameedit, int amount}) {
    final categorymodel = CategoryModel(categorynameedit, amount);
    final box = Boxes.getdata();
  }

  Future addData(
      List categoryList, int totalCategoryAmount, String time) async {
    final data = Data(
        categorylist: categoryList,
        totalAmount: totalCategoryAmount,
        time: time);

    final box = Boxes.getdata();

    box.add(data);
  }
}
