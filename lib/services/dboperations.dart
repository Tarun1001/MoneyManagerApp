import 'package:flutter/cupertino.dart';
import 'package:moneymanager/boxes.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';

class Dbservices with ChangeNotifier {
  void deleteData(int index) {
    final box = Boxes.getdata();
    box.deleteAt(index);

   
  }

  void editData(int index, value) {}

  //

  Future adddData(
      List categoryList, int totalCategoryAmount, String time) async {
    final data = Data(
        categorylist: categoryList,
        totalAmount: totalCategoryAmount,
        time: time);
        
    final box = Boxes.getdata();

    box.add(data);
  }
}
