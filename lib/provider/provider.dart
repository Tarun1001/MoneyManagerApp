import 'package:moneymanager/services/dboperations.dart';
import 'package:moneymanager/views/addcategoriescreen/viewhelper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // ChangeNotifierProvider(create: (_) => HomeModel()),
  ChangeNotifierProvider(create: (_) => ViewHelper()),
  ChangeNotifierProvider(create: (_) => Dbservices()),
  // ChangeNotifierProxyProvider<Dbservices, CategoryHelper>(
  //     create: (_) => CategoryHelper(),
  //     update: (_, dbservices,categoryhelper) =>
  //        categoryhelper..fetchdata(dbservices.databaseBox))
];
