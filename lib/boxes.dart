import 'package:hive/hive.dart';
import 'package:moneymanager/models/datamodel.dart/datamodel.dart';

class Boxes {
  Box<Data> getdata() => Hive.box<Data>("databaseBox");

}
