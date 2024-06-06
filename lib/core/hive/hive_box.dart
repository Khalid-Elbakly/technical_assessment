import 'package:technical_assessment/core/hive/boxes_and_lists.dart';
import 'package:technical_assessment/core/hive/hive_task_model.dart';

class HiveBox{

  static putAddTask(TaskModelHive task) async {
    AddBox!.put(task.taskName,task).then((value){

    }).catchError((e){
      print(e);
    });
  }

  static getAddTasks() {
    AddBox!.values.forEach((element){
      addTasksOffline.add(element);
    });
  }

  static putUpdateTask(TaskModelHive task){
    UpdateBox!.put(task.taskId,task).then((value){}).catchError((e){});
  }

  static getUpdateTasks(){
    UpdateBox!.values.forEach((element){
      updateTasksOffline.add(element);
    });
  }


  static putDeleteTask(TaskModelHive task){
    DeleteBox!.put(task.taskId,task).then((value){}).catchError((e){});
  }

  static getDeleteTasks(){
    DeleteBox!.values.forEach((element){
     deleteTasksOffline.add(element);
      });
  }

  static removeAddTask(taskName){
    AddBox!.delete(taskName);
  }


  static removeUpdateTask(taskId){
    UpdateBox!.delete(taskId);
  }

  static removeDeleteTask(taskId){
    DeleteBox!.delete(taskId);
  }


  static getData(){
    getAddTasks();
    getUpdateTasks();
    getDeleteTasks();
  }

}