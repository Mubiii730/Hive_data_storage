import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pat;
import 'package:saving_node_project/db_model.dart';
import 'package:saving_node_project/delete_addition.dart';


// void main() {
//   runApp(MaterialApp(home: MovingTriangle()));
// }

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  var path = await pat.getApplicationDocumentsDirectory();
   Hive.init(path.path);
   Hive.registerAdapter(DbModelAdapter());
    Hive.registerAdapter(OffsetAdapter());
   await Hive.openBox<DbModel>('triangleNodes');
   print(path.path);  
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:MovingTriangleHiveDeletion());
  }
}
