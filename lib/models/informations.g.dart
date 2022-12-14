// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InformationsAdapter extends TypeAdapter<Informations> {
  @override
  final int typeId = 1;

  @override
  Informations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Informations(
      name: fields[1] as String,
      description: fields[2] as String,
      rate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Informations obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InformationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
