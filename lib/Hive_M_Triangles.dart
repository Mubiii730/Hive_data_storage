
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saving_node_project/db_model.dart';
import 'package:saving_node_project/dbboxes.dart';
import 'package:uuid/uuid.dart';

class MovingTriangleHiveDeletion extends StatefulWidget {
  const MovingTriangleHiveDeletion({super.key});

  @override
  State<MovingTriangleHiveDeletion> createState() => _MovingTriangleHiveDeletionState();
}

class _MovingTriangleHiveDeletionState extends State<MovingTriangleHiveDeletion> {
  List<Offset> nodes = [];
  int? selectedNodeIndex;
var uuid = Uuid();

// DbModel? dbModel;
  Box? nodesBox;

  @override
  void initState() {
    super.initState();
   
    loadNodes();
  }

  
void dragNode(Offset position) {
  if (selectedNodeIndex != null) {
    var listData = DatabaseBoxes.getData();
    var existingkey;
    setState(() {
      listData.values.map((e) => setState(() {
        existingkey = e.key;
      })).toList();
      nodes[selectedNodeIndex!] = position;
      DbModel db = DbModel(nodes: nodes);
      DatabaseBoxes.getData().put(existingkey, db); 
    });
  }
}

void loadNodes() {
  DbModel? db = DatabaseBoxes.getData().get('nodes');
  if (db != null) {
    setState(() {
      nodes = db.nodes; 
    });
  }
}

void addNode(Offset position) {
  setState(() {
    var key = uuid.v1();
    nodes.add(position);
    DbModel db = DbModel(nodes: nodes);
    DatabaseBoxes.getData().put(key, db);  
  });
}

void deleteNode() {
  if (selectedNodeIndex != null) {
    var listData = DatabaseBoxes.getData();
    var existingkey;
    setState(() {
       listData.values.map((e) => setState(() {
        existingkey = e.key;
      })).toList();
      // Delete the node from the list
     nodes.removeAt(selectedNodeIndex!);
      
      // Delete the node from the database
      DatabaseBoxes.deleteUser(existingkey);
      
      // Clear selected node after deletion
      selectedNodeIndex = null;
    });
  }
}


//   void addNode(Offset position) {
//   setState(() {
//     var key = uuid.v1();
//     nodes.add(position);
//     DbModel db = DbModel( nodes: nodes);
//     DatabaseBoxes.getData().put(key, db);  
//   });
// }


// void dragNode(Offset position) {
//   if (selectedNodeIndex != null) {
//     var listData = DatabaseBoxes.getData();
//     var existingkey;
//     setState(() {
//       listData.values.map((e)=> setState(() {
//         existingkey = e.key;
//       })).toList();
//       nodes[selectedNodeIndex!] = position;
//         // DbModel db = DbModel(id:int.tryParse(uuid.v1()) ,nodes: nodes);
//         DbModel db = DbModel(nodes: nodes);

//       DatabaseBoxes.getData().put(existingkey,db); 
//     });
//   }
// }


// void loadNodes() {
//   DbModel? db = DatabaseBoxes.getData().get('nodes');
//   if (db != null) {
//     setState(() {
//       nodes = db.nodes; 
//     });
//   }
// }

  
  // void loadNodes() {
  //   final savedNodes = nodesBox?.get('triangleNodes', defaultValue: <Map<String, double>>[]);
  //   if (savedNodes != null) {
  //     setState(() {
  //       nodes = savedNodes.map((e) => Offset(e['dx']!, e['dy']!)).toList();
       
  //     });
  //   }
  // }




  
  bool isTapOnNode(Offset tapPosition) {
    for (int i = 0; i < nodes.length; i++) {  //scalability concern
      final nodePosition = nodes[i];
      final trianglePath = _getTrianglePath(nodePosition);
      if (trianglePath.contains(tapPosition)) {
        setState(() {
          selectedNodeIndex = i;  
        });
        return true;
      }
    }
    return false;
  }

 
  Path _getTrianglePath(Offset position) {
    final path = Path();
    final top = Offset(position.dx, position.dy);
    final left = Offset(position.dx - 40, position.dy + 20);
    final right = Offset(position.dx + 40, position.dy + 20);

    path.moveTo(top.dx, top.dy);
    path.lineTo(left.dx, left.dy);
    path.lineTo(right.dx, right.dy);
    path.close();
    return path;
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Center(child: Text('Moving Triangles', style: TextStyle(color: Colors.amberAccent))),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Clear all nodes and database
            DatabaseBoxes.deleteAllUser(nodes.length);
            setState(() {
              nodes.clear();
            });
          },
        ),
      ],
      backgroundColor: Colors.blue,
    ),
    body: GestureDetector(
      onTapUp: (details) {
        if (selectedNodeIndex == null) {
          addNode(details.localPosition);
        } else {
          setState(() {
            selectedNodeIndex = null; 
          });
        }
      },
     
      onPanUpdate: (details) {
        if (selectedNodeIndex != null) {
          dragNode(details.localPosition);
        }
      },
      onPanStart: (details) {
        if (isTapOnNode(details.localPosition)) {
          setState(() {});
        }
      },

      onDoubleTap: () {
        setState(() {
          
        });
        deleteNode();
      },
      
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: DatabaseBoxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<DbModel>();
            
           
           
            return Stack(
              children: data.isEmpty
                  ? [
                      CustomPaint(
                        size: Size.infinite,
                        painter: NodePainter(nodes),
                      ),
                    ]
                  : data.map((e) => CustomPaint(
                      size: Size.infinite,
                      painter: NodePainter(e.nodes),
                    )).toList(),
            );
          },
        ),
      ),
    ),
  );
}
}








//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Moving Triangles',style: TextStyle(color: Colors.amberAccent),)),
//         actions: [
//         IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: () {
//             DatabaseBoxes.deleteAllUser(nodes.length);
//             setState(() {
//               nodes.clear();
//             });
           
//           },
//         ),
//       ],
//        backgroundColor: Colors.blue,
        
//       ),
//       body: GestureDetector(
//         onTapUp: (details) {
//           if (selectedNodeIndex == null) {
//             addNode(details.localPosition);
//           } else {
//             setState(() {
//               selectedNodeIndex = null; 
//             });
//           }
//         },
//         onPanUpdate: (details) {
//           if (selectedNodeIndex != null) {
//             dragNode(details.localPosition);
//           }
//         },
//         onPanStart: (details) {
//           if (isTapOnNode(details.localPosition)) {
//             setState(() {
             
//             });
//           }
//         },
//         onLongPress: () {
//             if (selectedNodeIndex != null) {
//               setState(() {
//                 nodes.removeAt(selectedNodeIndex!);
//                 DatabaseBoxes.deleteUser(selectedNodeIndex!);
//                 loadNodes(); // Save updated list after deletion
//                 selectedNodeIndex = null;
//               });
//             }
//           },
//         child: Scaffold(
//           body: ValueListenableBuilder(valueListenable: DatabaseBoxes.getData().listenable(), 
//           builder: (context, box, _){
//             var data = box.values.toList().cast<DbModel>();
//             if(data.isEmpty){
//               return Stack(
//             children: [
//               CustomPaint(
//                 size: Size.infinite,
//                 painter: NodePainter(nodes),
//               ),
//             ],
//           );
//             } else {
//             return Stack(
//             children: data.map((e)=> CustomPaint(
//                 size: Size.infinite,
//                 painter: NodePainter(e.nodes),
//               ), ).toList()
             
//             ,
//           );
//             }
//           }) 
//         ),
//       ),
//     );
//   }
// }

class NodePainter extends CustomPainter {
  NodePainter(this.nodes);
  final List<Offset> nodes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (var position in nodes) {
      final path = Path();
      final top = Offset(position.dx, position.dy);
      final left = Offset(position.dx - 40, position.dy + 20);
      final right = Offset(position.dx + 40, position.dy + 20);

      path.moveTo(top.dx, top.dy);
      path.lineTo(left.dx, left.dy);
      path.lineTo(right.dx, right.dy);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
