import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/home_cubit.dart';
import 'custom_text_field.dart';

class TaskButtomSheet extends StatelessWidget {
  final bool update;
  const TaskButtomSheet({super.key, this.update = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal:  9.w,),
          child: Container(
            height: update ? 350.h : 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0), //(x,y)
                  spreadRadius: 3,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.close,color: Color(0xFFF24E1E),),iconSize: 20.sp,),
                      ],
                    ),
                    Text("Create New Task",style: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w600,fontSize: 15.sp),),
                    SizedBox(height: 14.h,),
                    CustomTextField(
                      hint: "Task Title",
                      controller: context.read<HomeCubit>().taskNameController,
                    ),
                    SizedBox(height: 7.h,),
                    CustomTextField(
                      hint: "Due Date",
                      readOnly: true,
                      controller: context.read<HomeCubit>().dateController,
                      onTap: () async {
                        context.read<HomeCubit>().date = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2050),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: Color(0xFF00CA5D), // header background color
                                      onPrimary: Colors.white, // header text color
                                      onSurface: Color(0xFF00CA5D).withOpacity(0.8) // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color(0xFF00CA5D), // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );});
                        context.read<HomeCubit>().setDate();
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    update ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: SizedBox(
                          width: double.infinity,
                          height: 30.h,
                          child: ElevatedButton(
                            onPressed: (){
                              context.read<HomeCubit>().changeStateOfTask();
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.green,
                                ),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.sp)))),
                            child: Text(
                              context.read<HomeCubit>().task!.done! ? "Not Done" :"Done",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                          )),
                    ) : const SizedBox(),
                    update ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: SizedBox(
                          width: double.infinity,
                          height: 30.h,
                          child: ElevatedButton(
                            onPressed: (){
                              context.read<HomeCubit>().addToCalendar();
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.green.withOpacity(.7),
                                ),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.sp)))),
                            child: Text(
                              "Add To Calendar",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                          )),
                    ) : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SizedBox(
                          width: double.infinity,
                          height: update ? 30.h : 53.h,
                          child: ElevatedButton(
                            onPressed: update ? (){
                              context.read<HomeCubit>().updateTask();
                              Navigator.pop(context);
                            } :
                                () {
                             context.read<HomeCubit>().createTask();
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(
                                  Color(0xFF00CA5D),
                                ),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.sp)))),
                            child: Text(
                             update ? "Update Task" : "Save Task",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                          )),
                    ),
                    update ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: SizedBox(
                          width: double.infinity,
                          height: 30.h,
                          child: ElevatedButton(
                            onPressed: (){
                              context.read<HomeCubit>().deleteTask();
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.red,
                                ),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.sp)))),
                            child: Text(
                              "Delete Task",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                          )),
                    ) : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
