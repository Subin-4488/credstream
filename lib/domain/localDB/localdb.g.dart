// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalDBUserAdapter extends TypeAdapter<LocalDBUser> {
  @override
  final int typeId = 1;

  @override
  LocalDBUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalDBUser(
      email: fields[0] as String,
      name: fields[1] as String,
      credentialWatermark: fields[4] as String,
    )
      ..loggedin = fields[2] as bool
      ..key = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, LocalDBUser obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.loggedin)
      ..writeByte(3)
      ..write(obj.key)
      ..writeByte(4)
      ..write(obj.credentialWatermark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalDBUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
