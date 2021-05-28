import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<CategoryModel> listofcategories = [
  CategoryModel("Food", 20),
  CategoryModel("Cloths", 40),
  CategoryModel("Internet", 10),
  CategoryModel("Electrcity", 40),
  CategoryModel("Flutter", 30),
  CategoryModel("Web", 90),
  CategoryModel("Website", 50),
  CategoryModel("Netflix", 85),
  CategoryModel("shopping", 70),
];

List<Data> listofdata = [
  Data(categorylist: listofcategories, time: "sdf", totalAmount: 880),
  Data(categorylist: listofcategories, time: "df", totalAmount: 56),
  Data(categorylist: listofcategories, time: "ggg", totalAmount: 300),
  Data(categorylist: listofcategories, time: "er", totalAmount: 448),
  Data(categorylist: listofcategories, time: "gg", totalAmount: 47),
  Data(categorylist: listofcategories, time: "hhhh", totalAmount: 600),
  Data(categorylist: listofcategories, time: "tinnme", totalAmount: 400),
  Data(categorylist: listofcategories, time: "fgg", totalAmount: 200),
  Data(categorylist: listofcategories, time: "large", totalAmount: 900),
];

getseriesdata() {
  List<charts.Series<CategoryModel, String>> series = [
    charts.Series(
        id: "Money",
        data: listofcategories,
        labelAccessorFn: (CategoryModel row, _) =>
            "${row.categoryName}:₹ ${row.categoryamount}",
        domainFn: (CategoryModel data, _) => data.categoryName,
        measureFn: (CategoryModel data, _) => data.categoryamount),
  ];
  return series;
}

getlistdataforgraph(Data data) {
  List list = data.categorylist;
  return list;
}
getseriesformaindata(Data data) {
  List<charts.Series<CategoryModel, String>> series = [
    charts.Series(
        id: "Money",
        data: getlistdataforgraph(data),
        labelAccessorFn: (CategoryModel row, _) =>
            "${row.categoryName}:₹ ${row.categoryamount}",
        domainFn: (CategoryModel data, _) => data.categoryName,
        measureFn: (CategoryModel data, _) => data.categoryamount),
  ];
  return series;
}
