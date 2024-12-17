// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class MovingTriangleHiveStored extends StatefulWidget {
//   const MovingTriangleHiveStored({super.key});

//   @override
//   State<MovingTriangleHiveStored> createState() => _MovingTriangleHiveStoredState();
// }

// class _MovingTriangleHiveStoredState extends State<MovingTriangleHiveStored> {
//   List<Offset> nodes = [];
//   int? selectedNodeIndex;


//   Box? nodesBox;

//   @override
//   void initState() {
//     super.initState();
//     loadNodes();
//     // _openBox();
//   }


//   // Future<void> _openBox() async {
   
//   //   // nodesBox = await Hive.openBox('triangleNodes');
//   //   loadNodes(); 
//   // }

 
//   void loadNodes() {
//     final savedNodes = nodesBox?.get('triangleNodes', defaultValue: <Map<String, double>>[]);
//     if (savedNodes != null) {
//       setState(() {
//         nodes = savedNodes.map((x) => Offset(x['dx']!, x['dy']!)).toList();
//       });
//     }
//   }

  
//   void addNode(Offset position) {
//     setState(() {
//       nodes.add(position);
//       nodesBox?.put('triangleNodes', nodes.map((x) => {'dx': x.dx, 'dy': x.dy}).toList()); 
//     });
//   }


//   void dragNode(Offset position) {
//     if (selectedNodeIndex != null) {
//       setState(() {
//         nodes[selectedNodeIndex!] = position;
//         nodesBox?.put('triangleNodes', nodes.map((x) => {'dx': x.dx, 'dy': x.dy}).toList()); 
//       });
//     }
//   }


//   bool isTapOnNode(Offset tapPosition) {
//     for (int i = 0; i < nodes.length; i++) {
//       final nodePosition = nodes[i];
//       final trianglePath = _getTrianglePath(nodePosition);
//       if (trianglePath.contains(tapPosition)) {
//         setState(() {
//           selectedNodeIndex = i;  
//         });
//         return true;
//       }
//     }
//     return false;
//   }

  
//   Path _getTrianglePath(Offset position) {
//     final path = Path();
//     final top = Offset(position.dx, position.dy);
//     final left = Offset(position.dx - 40, position.dy + 20);
//     final right = Offset(position.dx + 40, position.dy + 20);

//     path.moveTo(top.dx, top.dy);
//     path.lineTo(left.dx, left.dy);
//     path.lineTo(right.dx, right.dy);
//     path.close();
//     return path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapUp: (details) {
//         if (selectedNodeIndex == null) {
//           addNode(details.localPosition);
//         } else {
//           setState(() {
//             selectedNodeIndex = null; 
//           });
//         }
//       },
//       onPanUpdate: (details) {
//         if (selectedNodeIndex != null) {
//           dragNode(details.localPosition);
//         }
//       },
//       onPanStart: (details) {
//         if (isTapOnNode(details.localPosition)) {
//           setState(() {
          
//           });
//         }
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             CustomPaint(
//               size: Size.infinite,
//               painter: NodePainter(nodes),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NodePainter extends CustomPainter {
//   NodePainter(this.nodes);
//   final List<Offset> nodes;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     for (var position in nodes) {
//       final path = Path();
//       final top = Offset(position.dx, position.dy);
//       final left = Offset(position.dx - 40, position.dy + 20);
//       final right = Offset(position.dx + 40, position.dy + 20);

//       path.moveTo(top.dx, top.dy);
//       path.lineTo(left.dx, left.dy);
//       path.lineTo(right.dx, right.dy);
//       path.close();
//       canvas.drawPath(path, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
