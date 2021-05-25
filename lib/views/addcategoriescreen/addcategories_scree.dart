import 'package:flutter/material.dart';
import 'package:moneymanager/animations/popup_card/custom_rect_tween.dart';
import 'package:moneymanager/animations/popup_card/hero_dialoge_route.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/services/dboperations.dart';
import 'package:moneymanager/views/addcategoriescreen/viewhelper.dart';
import 'package:moneymanager/views/category%20Screen/categoryScreen.dart';
import 'package:moneymanager/views/addcategoriescreen/addcategory_popup.dart';

import 'package:provider/provider.dart';

class AddingScreen extends StatefulWidget {
  @override
  _AddingScreenState createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  @override
  Widget build(BuildContext context) {
    String time = Provider.of<ViewHelper>(context, listen: false).time;
    String totalamount =
        Provider.of<ViewHelper>(context, listen: false).totalamount.toString();

    return Scaffold(
      backgroundColor: constantColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time,
                    style: TextStyle(
                        color: constantColors.textcolor, fontSize: 17)),
                Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return AddcategoryPopup();
                        }));
                      },
                      child: Hero(
                        tag: "tag1",
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin, end: end);
                        },
                        child: CircleAvatar(
                          backgroundColor: constantColors.blueaccentcolor,
                          child: Icon(
                            Icons.add,
                            color: constantColors.bgcolor,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text("Total"),
              trailing: Text("\$\ $totalamount"),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: constantColors.bgcolor,
              child: Consumer<ViewHelper>(
                builder: (context, ViewHelper viewHelper, child) {
                  return ListView.builder(
                    itemCount: viewHelper.locallist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          deleteDialogue(
                              context, index, viewHelper.locallist[index], () {
                            Provider.of<ViewHelper>(context, listen: false)
                                .deletelocally(
                                    viewHelper.locallist[index], index);
                            Navigator.pop(context);
                          });
                        },
                        child: _buildCategorycontainer(
                            context, viewHelper.locallist[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.send),
        label: Text('Submit'),
        onPressed: () async {
          final list =
              Provider.of<ViewHelper>(context, listen: false).locallist;
          final amount =
              Provider.of<ViewHelper>(context, listen: false).totalamount;
          final time =
              Provider.of<ViewHelper>(context, listen: false).time.toString();

          // final finaldata = Data(list, amount, time);

         Provider.of<Dbservices>(context,listen: false). adddData(list, amount, time);
         
         

          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget _buildCategorycontainer(context, CategoryModel categoryModel) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Row(
      children: [
        Container(
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 25,
                child: Text(
                  categoryModel.categoryName,
                  style: TextStyle(
                      color: constantColors.textcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                  top: 15,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        "\$\ ${categoryModel.categoryamount.toString()}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ))
            ],
          ),
          color: constantColors.boxcolor,
          height: 50,
          width: MediaQuery.of(context).size.width * 0.77,
        ),
      ],
    ),
  );
}
