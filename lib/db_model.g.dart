// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbModelAdapter extends TypeAdapter<DbModel> {
  @override
  final int typeId = 0;

  @override
 DbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    final nodes = (fields[0] as List).cast<Map>().map((e) {
      // Deserialize the Offset objects
      return Offset(e['dx'], e['dy']);
    }).toList();
    return DbModel(
      nodes: nodes,
    );
  }


  @override
    void write(BinaryWriter writer, DbModel obj) {
    writer
      ..writeByte(1) // Number of fields
      ..writeByte(0) // Field 0 (nodes)
      ..write(obj.nodes.map((node) {
        // Serialize each Offset object as a map of dx and dy
        return {'dx': node.dx, 'dy': node.dy};
      }).toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
