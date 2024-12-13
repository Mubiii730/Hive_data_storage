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
    return DbModel(
      nodes: (fields[0] as List).cast<Offset>(),
    );
  }

  @override
  void write(BinaryWriter writer, DbModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nodes);
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


class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final int typeId = 1; // Unique ID for this adapter

  @override
  Offset read(BinaryReader reader) {
    final x = reader.readDouble(); // Read the x coordinate
    final y = reader.readDouble(); // Read the y coordinate
    return Offset(x, y); // Return the Offset object
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer.writeDouble(obj.dx); // Write the x coordinate
    writer.writeDouble(obj.dy); // Write the y coordinate
  }
}
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
    return DbModel(
      nodes: (fields[0] as List).cast<Offset>(),
    );
  }

  @override
  void write(BinaryWriter writer, DbModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nodes);
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


class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final int typeId = 1; // Unique ID for this adapter

  @override
  Offset read(BinaryReader reader) {
    final x = reader.readDouble(); // Read the x coordinate
    final y = reader.readDouble(); // Read the y coordinate
    return Offset(x, y); // Return the Offset object
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer.writeDouble(obj.dx); // Write the x coordinate
    writer.writeDouble(obj.dy); // Write the y coordinate
  }
}
