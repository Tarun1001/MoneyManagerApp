import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:moneymanager/views/statistics_screen/stat_screen_helpers.dart';

class DatawidgetStat extends StatelessWidget {
  final Data data;

  const DatawidgetStat({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          "Details >",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ))
              ],
            ),
            color: constantColors.boxcolor,
            height: 50,
            width: MediaQuery.of(context).size.width * 0.91,
          ),
        ],
      ),
    );
  }
}

showpiechartBMS(BuildContext context, Data data) {
  return showModalBottomSheet(
      backgroundColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      context: (context),
      builder: (
        context,
      ) {
        return Container(
          decoration: BoxDecoration(
              color: constantColors.boxcolor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          padding: EdgeInsets.all(50),
          height: MediaQuery.of(context).size.height * 0.5,
          width: 500,
          child: charts.PieChart(
            getseriesformaindata(data),
            animate: true,
            defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 60,
                arcRendererDecorators: [new charts.ArcLabelDecorator()]),
          ),
        );
      });
}
