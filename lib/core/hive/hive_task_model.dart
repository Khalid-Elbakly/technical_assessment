import 'package:hive/hive.dart';

part 'hive_task_model.g.dart';

@HiveType(typeId: 0)
class TaskModelHive extends HiveObject {
  @HiveField(0)
  String? taskName;

  @HiveField(1)
  bool? done;

  @HiveField(2)
  String? dueDate;

  @HiveField(3)
  String? taskId;

  TaskModelHive({
    required this.taskName,
    required this.dueDate,
    required this.done,
    this.taskId
  });
}