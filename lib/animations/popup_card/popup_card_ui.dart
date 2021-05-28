import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/animations/popup_card/custom_rect_tween.dart';
import 'package:moneymanager/constants/colors.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';

final ConstantColors constantColors = ConstantColors();

class AddCategoryPopupCard extends StatefulWidget {
  @override
  _AddCategoryPopupCardState createState() => _AddCategoryPopupCardState();
}

class _AddCategoryPopupCardState extends State<AddCategoryPopupCard> {
  TextEditingController _categoryTextController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String get getcategoryname => _categoryTextController.text;
  String get getamount => _amountController.text;

  void addCategory(CategoryModel categoryModel) {
    final categorymodeladapter = Hive.box("category");
    categorymodeladapter.add(categoryModel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "addcatogerytag",
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: constantColors.boxcolor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _categoryTextController,
                      decoration: InputDecoration(
                        hintText: "Category Type",
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: 'Enter the Amount',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 1,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    MaterialButton(
                      onPressed: () {
                        final newcategory = CategoryModel(
                            getcategoryname, int.parse(getamount));
                        addCategory(newcategory);
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
