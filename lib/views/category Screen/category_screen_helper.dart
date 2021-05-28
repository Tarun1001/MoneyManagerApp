import 'package:flutter/material.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/constants/dimentions.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:moneymanager/views/addcategoriescreen/addcategories_screen.dart';



Widget buildCategoryBox(BuildContext context, Data data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
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
                        "₹ ${data.totalAmount.toString()}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ))
            ],
          ),
          decoration: BoxDecoration(color: constantColors.boxcolor, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ]),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.94,
        ),
      ],
    ),
  );
}

detailsBMS(Data data, BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: constantColors.bgcolor),
        child: Column(
          children: [
            vSizedBox20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                    color: constantColors.boxcolor,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        "Total Spent  ",
                        style: TextStyle(fontSize: 17),
                      ),
                      Spacer(),
                      Text(
                        " ₹ ${data.totalAmount.toString()}",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ),
           vSizedBox20,
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.categorylist.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onLongPress: () {
                        // editCategoryPopup(data.categorylist[index],context);
                      },
                      child: buildCategorycontainer(
                          context, data.categorylist[index]),
                    ));
              },
            ),
          ],
        ),
      );
    },
  );
}

// This is used in two situations 

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
