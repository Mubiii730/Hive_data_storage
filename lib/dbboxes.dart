import 'package:hive/hive.dart';
import 'package:saving_node_project/db_model.dart';

class DatabaseBoxes{
  
 static Box<DbModel> getData() => Hive.box<DbModel>('triangleNodes');

 
  static deleteAllUser(int key) { 

    // return getData().deleteAll(getData().keys);
    return getData().clear(); 
  } 

  static deleteUser(String key){
    // return getData().deleteAt(getData().keyAt(key));
    return getData().delete(key);
  }

}
