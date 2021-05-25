import 'package:hive/hive.dart';
import 'package:moneymanager/models/categoryModel/category_Model.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 1)
class Data extends HiveObject {
  @HiveField(0)
  final List<CategoryModel> categorylist;

  @HiveField(1)
  final int totalAmount;

  @HiveField(2)
  final String time;

  Data(
    {this.categorylist,
    this.totalAmount,
    this.time,}
  );
}
