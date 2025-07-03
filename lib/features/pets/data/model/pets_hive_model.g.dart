// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetsHiveModelAdapter extends TypeAdapter<PetsHiveModel> {
  @override
  final int typeId = 0;

  @override
  PetsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetsHiveModel(
      name: fields[0] as String,
      breed: fields[1] as String,
      age: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetsHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.breed)
      ..writeByte(2)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
