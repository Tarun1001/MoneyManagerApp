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
