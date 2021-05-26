import 'package:flutter/material.dart';
import 'package:moneymanager/animations/popup_card/custom_rect_tween.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/views/addcategoriescreen/viewhelper.dart';
import 'package:provider/provider.dart';

class AddcategoryPopup extends StatefulWidget {
  @override
  _AddcategoryPopupState createState() => _AddcategoryPopupState();
}

class _AddcategoryPopupState extends State<AddcategoryPopup> {
  TextEditingController _categoryTextController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  String get getcategoryname => _categoryTextController.text;
  String get getamount => _amountController.text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "tag1",
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
                        hintText: "Category Name",
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: 'Amount',
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
                      onPressed: () async {
                        final CategoryModel categoryModel = CategoryModel(
                            getcategoryname, int.parse(getamount));

                        Provider.of<ViewHelper>(context, listen: false)
                            .addlocally(categoryModel);

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

editCategoryPopup(CategoryModel categoryModel, BuildContext context) {
  TextEditingController categoryTextController = TextEditingController()
    ..text = categoryModel.categoryName;
  TextEditingController amountController = TextEditingController()
    ..text = categoryModel.categoryamount.toString();

  return showModalBottomSheet(
    backgroundColor: constantColors.bgcolor,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: constantColors.boxcolor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onSubmitted: (value) {
                          categoryTextController.text = value;
                        },
                        controller: categoryTextController,
                        decoration: InputDecoration(
                          hintText: "Category Name",
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextField(
                        onSubmitted: (value) {
                          amountController.text = value;
                        },
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: InputDecoration(
                          hintText: "Amount",
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
                        onPressed: () async {
                          


                        },
                        child: const Text('Confirm Edit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
