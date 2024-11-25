import 'package:hive/hive.dart';
import 'package:saving_node_project/db_model.dart';

class DatabaseBoxes{
  
 static Box<DbModel> getData() => Hive.box<DbModel>('triangleNodes');
}