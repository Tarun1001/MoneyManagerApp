import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';

class ViewHelper with ChangeNotifier {
  String _timeString;
  String get time => _timeString;

  List<CategoryModel> _locallist = [];
  List<CategoryModel> get locallist => _locallist;

  int _totalamount = 0;
  int get totalamount => _totalamount;

  incrementamount(CategoryModel categoryModel) {
    _totalamount = _totalamount + categoryModel.categoryamount;
    notifyListeners();
  }

  decrementamount(CategoryModel categoryModel) {
    _totalamount = _totalamount - categoryModel.categoryamount;
    notifyListeners();
  }

  void getTime() {
    final formattedDateTime = DateTime.now();
    _timeString = formattedDateTime.toString();
    notifyListeners();
  }

  addlocally(CategoryModel categoryModel) {
    _locallist.add(categoryModel);
    incrementamount(categoryModel);

    notifyListeners();
  }

  deletelocally(CategoryModel categoryModel, int index) {
    _locallist.removeAt(index);
    decrementamount(categoryModel);

    notifyListeners();
  }

  clearlocal() {
    _locallist.clear();
    _totalamount = 0;
    notifyListeners();
  }
}
