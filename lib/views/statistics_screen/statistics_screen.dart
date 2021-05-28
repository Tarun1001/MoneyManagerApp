import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/animations/popup_card/popup_card_ui.dart';
import 'package:moneymanager/boxes.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/views/statistics_screen/stat_screen_helpers.dart';
import 'package:moneymanager/views/statistics_screen/stat_screen_widgets.dart';

class StatisticsScreen extends StatelessWidget  with Boxes {
  const StatisticsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.bgcolor,
      body: Column(
        children: [
          Container(
            height: 300,
            padding: EdgeInsets.all(10),
            child: Card(
              color: constantColors.blueaccentcolor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Latest Transaction",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: new charts.PieChart(
                        getseriesformaindata(getdata().getAt(0)),
                        animate: true,
                        defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 60,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  insideLabelStyleSpec:
                                      charts.TextStyleSpec(fontSize: 15))
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("  Statictics",
                            style: TextStyle(
                                color: constantColors.textcolor, fontSize: 17)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: constantColors.bgcolor,
                      child: ValueListenableBuilder<Box<Data>>(
                        valueListenable:getdata().listenable(),
                        builder: (BuildContext context, box, child) {
                          final data = box.values.toList().cast<Data>();
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                int finalindex = data.length - index - 1;

                                if (index == 0) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () => showpiechartBMS(
                                        context, data[finalindex]),
                                    child: DatawidgetStat(
                                      data: data[finalindex],
                                    ),
                                  );
                                }
                              });
                        },
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
