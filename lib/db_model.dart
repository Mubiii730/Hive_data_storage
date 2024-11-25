import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'db_model.g.dart';


@HiveType(typeId:0)
class DbModel extends HiveObject {
  
  @HiveField(0)
  List<Offset> nodes;

  DbModel({required this.nodes,});

}