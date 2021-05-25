import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/boxes.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:moneymanager/services/dboperations.dart';
import 'package:moneymanager/views/addcategoriescreen/addcategories_scree.dart';
import 'package:moneymanager/views/addcategoriescreen/viewhelper.dart';
import 'package:moneymanager/views/homepage/homemodel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _detailsWidget(Data data, int index) {
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          print(data.categorylist.length);
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: constantColors.bgcolor),
            child: ListView.builder(
              itemCount: data.categorylist.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: constantColors.blueaccentcolor,
                    leading: Text(data.categorylist[index].categoryName),
                    title: Text(
                        data.categorylist[index].categoryamount.toString()),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            _buildAccountBalanceCard(context),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("   Payments",
                    style: TextStyle(
                        color: constantColors.textcolor, fontSize: 17)),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: AddButton(),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
                child: Container(
              color: constantColors.bgcolor,
              child: ValueListenableBuilder<Box<Data>>(
                valueListenable: Boxes.getdata().listenable(),
                builder: (BuildContext context, box, child) {
                  final data = box.values.toList().cast<Data>();
                  return ListView.builder(
                    itemCount:data.length,
                    itemBuilder: (context, index) {
                      print(box.values.length);
                      return GestureDetector(
                         child: _buildCategoryBox(
                              context, index, data[index]),
                          onTap: () {
                            _detailsWidget(data[index], index);
                          },
                          onLongPress: () {
                            deleteDialogueforCategoryscreen(context, index, () {
                              Provider.of<Dbservices>(context, listen: false)
                                  .deleteData(
                                index,
                              );
                              Navigator.pop(context);
                            });
                          },
                         );
                    },
                  );
                },
              ),

            
            ))
            // Expanded(
            //     child: Container(
            //         color: constantColors.bgcolor,
            //         // ignore: deprecated_member_use
            //         child: Consumer<Dbservices>(
            //           builder: (context, value, child) {
            //             var data = value.listFromHive;
            //             return ListView.builder(
            //               itemCount: data.length,
            //               itemBuilder: (context, index) {
            //                 print(data.length);
            //                 return GestureDetector(
            //                     onTap: () {
            //                       _detailsWidget(data[index], index);
            //                     },
            //                     onLongPress: () {
            //                       deleteDialogueforCategoryscreen(
            //                           context, index, () {
            //                         Provider.of<Dbservices>(context,
            //                                 listen: false)
            //                             .deleteData(
            //                           index,
            //                         );
            //                         Navigator.pop(context);
            //                       });
            //                     },
            //                     child: _buildCategoryBox(
            //                         context, index, data[index]));
            //               },
            //             );
            //           },
            //         )))
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ViewHelper>(context, listen: false).getTime();
        Navigator.push(
            context,
            PageTransition(
                child: AddingScreen(), type: PageTransitionType.bottomToTop));
      },
      child: CircleAvatar(
        backgroundColor: constantColors.boxcolor,
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _buildCategoryBox(BuildContext context, int index, Data data) {
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
                  data.time,
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
                        "$index",
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

Widget _buildAccountBalanceCard(context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: constantColors.blueaccentcolor.withOpacity(0.7),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 120,
          right: 150,
          child: CircleAvatar(
            radius: 150,
            backgroundColor: constantColors.boxcolor,
          ),
        ),
        Positioned(
          bottom: 90,
          left: 190,
          child: CircleAvatar(
            radius: 150,
            backgroundColor: constantColors.boxcolor,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 50,
          child: Row(
            children: [
              Text(
                "Income",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              SizedBox(
                width: 150,
              ),
              Consumer<HomeModel>(
                builder: (context, model, child) => Text(
                  "\$\ ${model.income - model.totalcost}",
                  style:
                      TextStyle(color: constantColors.textcolor, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Row(
            children: [
              Text(
                "Balance",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              SizedBox(
                width: 150,
              ),
              Consumer<HomeModel>(
                builder: (context, model, child) => Text(
                  "\$\ ${model.totalcost} ",
                  style:
                      TextStyle(color: constantColors.textcolor, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    height: MediaQuery.of(context).size.height * 0.3,
    width: double.infinity,
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

deleteDialogueforCategoryscreen(
    BuildContext context, int index, Function onpressed) {
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
