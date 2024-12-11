import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saving_node_project/db_model.dart';
import 'package:saving_node_project/dbboxes.dart';

class MovingTriangleHive extends StatefulWidget {
  const MovingTriangleHive({super.key});

  @override
  State<MovingTriangleHive> createState() => _MovingTriangleHiveState();
}

class _MovingTriangleHiveState extends State<MovingTriangleHive> {
  List<Offset> nodes = [];
  int? selectedNodeIndex;

  // Open the box to store the nodes
  Box? nodesBox;

  @override
  void initState() {
    super.initState();
    // _openBox();  // Open the Hive box
  }

  // Function to open the Hive box to store and retrieve data
  // Future<void> _openBox() async {
  //   await Hive.initFlutter();
  //   nodesBox = await Hive.openBox('triangleNodes');
  //   loadNodes();  // Load previously saved nodes
  // }


  // Load nodes from the Hive box
  void loadNodes() {
    final savedNodes = nodesBox?.get('triangleNodes', defaultValue: <Map<String, double>>[]);
    if (savedNodes != null) {
      setState(() {
        nodes = savedNodes.map((e) => Offset(e['dx']!, e['dy']!)).toList();
        // dbnodes=DatabaseBoxes.getData().get('key')
      });
    }
  }

  

  // Function to add a new node
  void addNode(Offset position) {
    setState(() {
      // dbnodes=nodes as List<DbModel>;
      nodes.add(position);
      DbModel db = DbModel(nodes: nodes);
      DatabaseBoxes.getData().add(db);
      // Save updated nodes to Hive
    });
  }

  // Function to drag a node                                                                                                                        //The problem is somewhere in dragnode function.
  void dragNode(Offset position) {
    if (selectedNodeIndex != null) {
      setState(() {
        nodes[selectedNodeIndex!] = position;
        DbModel db = DbModel(nodes: nodes);
        DatabaseBoxes.getData().put('node', db);
        // nodesBox?.put('triangleNodes', nodes.map((e) => {'dx': e.dx, 'dy': e.dy}).toList()); // Save updated nodes to Hive
      });
    }
  }

  // Check if the tap is on an existing node
  bool isTapOnNode(Offset tapPosition) {
    for (int i = 0; i < nodes.length; i++) {  //scalability concern
      final nodePosition = nodes[i];
      final trianglePath = _getTrianglePath(nodePosition);
      if (trianglePath.contains(tapPosition)) {
        setState(() {
          selectedNodeIndex = i;  // Select the node
        });
        return true;
      }
    }
    return false;
  }

  // Function to generate the triangle path for a given node position
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
    return GestureDetector(
      onTapUp: (details) {
        if (selectedNodeIndex == null) {
          addNode(details.localPosition);
        } else {
          setState(() {
            selectedNodeIndex = null; // Deselect node if tapped outside
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
          setState(() {
            // Node selected, ready to drag
          });
        }
      },
      child: Scaffold(
        body: ValueListenableBuilder(valueListenable: DatabaseBoxes.getData().listenable(), 
        builder: (context, box, _){
          var data = box.values.toList().cast<DbModel>();
          if(data.isEmpty){
            return Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: NodePainter(nodes),
            ),
          ],
        );
          } else {
          return Stack(
          children: data.map((e)=> CustomPaint(
              size: Size.infinite,
              painter: NodePainter(e.nodes),
            ), ).toList()
           
          ,
        );
          }
        }) 
      ),
    );
  }
}

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
