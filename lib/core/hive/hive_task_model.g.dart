// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

  class TaskModelHiveAdapter extends TypeAdapter<TaskModelHive> {
  @override
  final int typeId = 0;

  @override
  TaskModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModelHive(
      taskName: fields[0] as String?,
      dueDate: fields[2] as String?,
      done: fields[1] as bool?,
      taskId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModelHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.done)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.taskId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
