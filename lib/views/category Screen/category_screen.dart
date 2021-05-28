import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/boxes.dart';
import 'package:moneymanager/constants/dimentions.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:moneymanager/services/dboperations.dart';
import 'package:moneymanager/views/addcategoriescreen/addcategories_screen.dart';
import 'package:moneymanager/provider/addcategory_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'category_screen_helper.dart';

class CategoryScreen extends StatelessWidget with Boxes {
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            vSizedBox1,
            _buildAccountBalanceCard(context),
            vSizedBox1,
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
            vSizedBox2,
            Expanded(
                child: Container(
              color: constantColors.bgcolor,
              child: ValueListenableBuilder<Box<Data>>(
                valueListenable: getdata().listenable(),
                builder: (BuildContext context, box, child) {
                  final data = box.values.toList().cast<Data>();
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      int finalindex = data.length - index - 1;

                      return GestureDetector(
                        child: buildCategoryBox(context, data[finalindex]),
                        onTap: () {
                          detailsBMS(data[finalindex], context);
                        },
                        onLongPress: () {
                          deleteDialogueforCategoryscreen(context, finalindex,
                              () {
                            Provider.of<Dbservices>(context, listen: false)
                                .deleteData(
                              finalindex,
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
          ],
        ),
      ),
    );
  }
}

//add iconbuttton

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AddCategoryProvider>(context, listen: false).getTime();
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

//Card
Widget _buildAccountBalanceCard(context) {
  return Container(
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
                "Account Balance",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              SizedBox(
                width: 150,
              ),
              Text(
                "XXXX",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              // Consumer<HomeModel>(
              //   builder: (context, model, child) => Text(
              //     "XXXX",
              //     style:
              //         TextStyle(color: constantColors.textcolor, fontSize: 17),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Row(
            children: [
              Text(
                "Acc Number",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              SizedBox(
                width: 100,
              ),
              Text(
                "XXXX XXXX XXXX",
                style: TextStyle(color: constantColors.textcolor, fontSize: 17),
              ),
              // Consumer<HomeModel>(
              //   builder: (context, model, child) => Text(
              //     "XXXX XXXX XXXX ",
              //     style:
              //         TextStyle(color: constantColors.textcolor, fontSize: 17),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ),
    height: MediaQuery.of(context).size.height * 0.3,
    width: double.infinity,
  );
}

// Expanded(
//     child: Container(
//         color: constantColors.bgcolor,
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
