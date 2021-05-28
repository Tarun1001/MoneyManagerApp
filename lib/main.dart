import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';
import 'package:moneymanager/provider/provider.dart';
import 'package:moneymanager/views/homepage/homepage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(DataAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,      
        title: 'Moneymanager',    
        theme: ThemeData(
          fontFamily: "Montserrat",
          brightness: Brightness.dark,
        ),
        home: FutureBuilder(
            future: Hive.openBox<Data>("databaseBox"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else
                  return HomePage();
              } else {
                return Scaffold();
              }
            }),
      ),
      providers: providers,
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
