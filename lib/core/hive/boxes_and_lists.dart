import 'package:hive_flutter/hive_flutter.dart';

import 'hive_task_model.dart';

Box<TaskModelHive>? AddBox;
Box<TaskModelHive>? UpdateBox;
Box<TaskModelHive>? DeleteBox;

List<TaskModelHive> addTasksOffline =[];
List<TaskModelHive> updateTasksOffline = [];
List<TaskModelHive> deleteTasksOffline = [];
