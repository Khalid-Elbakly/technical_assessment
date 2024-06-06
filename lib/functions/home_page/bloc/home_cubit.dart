import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:technical_assessment/core/hive/boxes_and_lists.dart';
import 'package:technical_assessment/core/hive/hive_box.dart';
import 'package:technical_assessment/core/hive/hive_task_model.dart';
import 'package:technical_assessment/core/models/task_model.dart';
import 'package:technical_assessment/core/network_service.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  var db = FirebaseFirestore.instance;

  List<TaskModel> allTasks = [];
  List<TaskModel> doneTasks = [];
  List<TaskModel> notDoneTasks = [];

  List<TaskModel> tasks = [];

  bool all = true;
  bool doneFilter = false;
  bool notDoneFilter = false;

  onDoneFilterPressed() {
    tasks.clear();
    for (var element in allTasks) {
      if (element.done == true) {
        tasks.add(element);
      }
    }
    notDoneFilter = false;
    all = false;
    doneFilter = true;
    emit(HomeSuccessState());
    emit(HomeInitialState());
  }

  onNotDoneFilterPressed() {
    tasks.clear();
    for (var element in allTasks) {
      if (element.done == false) {
        tasks.add(element);
      }
    }
    all = false;
    doneFilter = false;
    notDoneFilter = true;
    emit(HomeSuccessState());
    emit(HomeInitialState());
  }

  onAllFilterPressed() {
    tasks.clear();
    for (var element in allTasks) {
      tasks.add(element);
    }
    notDoneFilter = false;
    doneFilter = false;
    all = true;
    emit(HomeSuccessState());
    emit(HomeInitialState());
  }

  taskNameValidator(){
    if(taskNameController.text.isNotEmpty){
      return null;
    }
    else{
      return "Please Enter Task Name";
    }
  }

  dateValidator(){
    if(dateController.text.isNotEmpty){
      return null;
    }
    else{
      return "Please Choose Task date";
    }
  }


  Future<void> createTask(BuildContext context) async {
    if (formKey.currentState!.validate()){
      Navigator.pop(context);
      if (await NetworkService.isConnected == true) {
        TaskModel taskModel = TaskModel(
            taskName: taskNameController.text,
            dueDate: dateController.text,
            done: false);

        db.collection("tasks").doc().set(taskModel.toJson()).then((value) {
          getTasks();
        }).catchError((error) {
          print(error);
        });
      }
      else {
        HiveBox.putAddTask(TaskModelHive(taskName: taskNameController.text,
          dueDate: dateController.text,
          done: false,));
      }}
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  addToCalendar(){
    final Event event = Event(
        title: task!.taskName!,
        startDate: DateFormat("yyyy-MM-dd").parse(task!.dueDate!),
        endDate: DateFormat("yyyy-MM-dd").parse(task!.dueDate!));
    Add2Calendar.addEvent2Cal(event);
  }

  getTasks() {
    // emit(HomeLoadingState());
    allTasks = [];
    tasks = [];
    db.collection("tasks").get().then((value) {
      var docSnapShot = value.docs;
      for (int i = 0; i < docSnapShot.length; i++) {
        allTasks.add(
            TaskModel.fromJson(docSnapShot[i].data(), id: docSnapShot[i].id));
      }
      onAllFilterPressed();
      // emit(HomeSuccessState());
    }).catchError((error) {
      HomeFailureState();
    });
    emit(HomeInitialState());
  }

  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? date;

  setDate() async {
    if (date != null) {
      dateController.text = date.toString().split(" ")[0];
    }

    emit(HomeSuccessState());
    emit(HomeInitialState());
  }

  updateTask({bool? done}) async {
    emit(HomeLoadingState());
    if (await NetworkService.isConnected == true) {
      db
          .collection("tasks")
          .doc(task!.taskId)
          .update(TaskModel(
                  taskName: taskNameController.text,
                  dueDate: dateController.text,
                  done: done ?? task!.done)
              .toJson())
          .then((value) {
        getTasks();
      }).catchError((error) {});
    } else {
      HiveBox.putUpdateTask(TaskModelHive(
          taskName: taskNameController.text,
          dueDate: dateController.text,
          done: done ?? task!.done,
          taskId: task!.taskId));
    }}

  deleteTask() async {
    if (await NetworkService.isConnected == true) {
      db.collection("tasks").doc(task!.taskId).delete().then((value) {
        getTasks();
      }).catchError((error) {});
    } else {
      HiveBox.putDeleteTask(TaskModelHive(
          taskName: task!.taskName,
          dueDate: task!.dueDate,
          done: task!.done,
          taskId: task!.taskId));
    }
  }

  addTaskAfterOnline() {
    addTasksOffline.forEach((element){
      TaskModel taskModel = TaskModel(
          taskName: element.taskName,
          dueDate: element.dueDate,
          done: false);

      db.collection("tasks").doc().set(taskModel.toJson()).then((value) {
        addTasksOffline.remove(element);
        HiveBox.removeAddTask(element.taskName);
      }).catchError((error) {
        print(error);
      });
    });
  }

  updateTaskAfterOnline(){
    updateTasksOffline.forEach((element){
    db
        .collection("tasks")
        .doc(element.taskId)
        .update(TaskModel(
        taskName: element.taskName,
        dueDate: element.dueDate,
        done: element.done)
        .toJson())
        .then((value) {
      updateTasksOffline.remove(element);
      HiveBox.removeUpdateTask(element.taskId);
    }).catchError((error) {});
  });
  }

  deleteTaskAfterOnline() {
    deleteTasksOffline.forEach((element) {
      db.collection("tasks").doc(element.taskId).delete().then((value) {
        deleteTasksOffline.remove(element);
        HiveBox.removeDeleteTask(element.taskId);
      }).catchError((error) {});
    });
  }

  TaskModel? task;

  onTaskPressed(int index) {
    task = allTasks[index];
    taskNameController.text = task!.taskName!;
    dateController.text = task!.dueDate!;
  }

  changeStateOfTask() {
    updateTask(done: !(task!.done!));
  }

  void initBottomSheet() {
    taskNameController.clear();
    dateController.clear();
  }

  onConnectListen() async {
    try {
      await HiveBox.getData();
      await deleteTaskAfterOnline();
      await addTaskAfterOnline();
      await updateTaskAfterOnline();
      await getTasks();
    } catch (error) {
      print("An error occurred: $error");
    }
  }
}
