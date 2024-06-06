class TaskModel{
  String? taskName;
  bool? done;
  String? dueDate;
  String? taskId;

  TaskModel({required this.taskName,required this.dueDate,required this.done});

    TaskModel.fromJson(Map<String,dynamic> json,{required id}){
    taskName = json["task_name"];
    done = json["done"];
    dueDate = json["date"];
    taskId = id;
  }

  Map<String,dynamic> toJson(){
    return {
      "task_name" : taskName,
      "done" : done,
      "date" : dueDate,
    };
  }
}