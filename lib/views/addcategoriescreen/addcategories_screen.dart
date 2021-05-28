import 'package:flutter/material.dart';
import 'package:moneymanager/animations/popup_card/custom_rect_tween.dart';
import 'package:moneymanager/animations/popup_card/hero_dialoge_route.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/services/dboperations.dart';
import 'package:moneymanager/provider/addcategory_provider.dart';
import 'package:moneymanager/views/addcategoriescreen/addcategory_popup.dart';
import 'package:provider/provider.dart';

class AddingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String time = Provider.of<AddCategoryProvider>(context, listen: false).time;
    String totalamount =
        Provider.of<AddCategoryProvider>(context, listen: false).totalamount.toString();

    return Scaffold(
      backgroundColor: constantColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time,
                        style: TextStyle(
                            color: constantColors.textcolor, fontSize: 17)),
                    GestureDetector(
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Text("Total"),
                trailing: Text("₹ $totalamount"),
              ),
              ///used consumer here
              ///
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                color: constantColors.bgcolor,
                child: Consumer<AddCategoryProvider>(
                  builder: (context, AddCategoryProvider viewHelper, child) {
                    return ListView.builder(
                      itemCount: viewHelper.locallist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            deleteDialogue(
                                context, index, viewHelper.locallist[index],
                                () {
                              Provider.of<AddCategoryProvider>(context, listen: false)
                                  .deletelocally(
                                      viewHelper.locallist[index], index);
                              Navigator.pop(context);
                            });
                          },
                          child: buildCategorycontainer(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.send),
        label: Text('Confirm'),
        onPressed: () async {
          final list =
              Provider.of<AddCategoryProvider>(context, listen: false).locallist;
          final amount =
              Provider.of<AddCategoryProvider>(context, listen: false).totalamount;
          final time =
              Provider.of<AddCategoryProvider>(context, listen: false).time.toString();

          Provider.of<Dbservices>(context, listen: false)
              .addData(list, amount, time);

          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget buildCategorycontainer(context, CategoryModel categoryModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                        "₹ ${categoryModel.categoryamount.toString()}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ))
            ],
          ),
          decoration: BoxDecoration(
            color: constantColors.boxcolor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 7.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ],
          ),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.92,
        ),
      ],
    ),
  );
}

deleteDialogue(BuildContext context, int index, CategoryModel currentmodel,
    Function onpressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: constantColors.boxcolor,
          title: Text(
            "Delete  ? ",
            style: TextStyle(
                color: constantColors.textcolor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      color: constantColors.textcolor,
                      decoration: TextDecoration.underline,
                      decorationColor: constantColors.bgcolor),
                )),
            MaterialButton(
                color: constantColors.blueaccentcolor,
                onPressed: onpressed,
                child: Text(
                  "Yes",
                  style: TextStyle(
                      color: constantColors.textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ))
          ],
        );
      });
}
