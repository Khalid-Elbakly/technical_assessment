import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_cubit.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_states.dart';
import 'package:technical_assessment/functions/home_page/components/task_bottom_sheet.dart';
import 'package:technical_assessment/functions/home_page/components/status_component.dart';
import 'package:technical_assessment/functions/home_page/components/task_container.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state) {},
          builder:(context,state){
            return GestureDetector(
              onTap: (){
                if(Navigator.canPop(context)) {
                Navigator.pop(context);
                }},
              child: Padding(
              padding:
                  EdgeInsets.only(left: 22.w, right: 22.w, bottom: 17.h, top: 31.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                   Row(
                    children: [
                      StatusComponent(
                        onTap: (){
                          context.read<HomeCubit>().onAllFilterPressed();
                        },
                        height: 21.h,
                        width: 59.w,
                        text: "All",
                        isActive: context.read<HomeCubit>().all,
                      ),
                      StatusComponent(
                        onTap: (){
                          context.read<HomeCubit>().onNotDoneFilterPressed();
                        },
                        height: 21.h,
                        width: 59.w,
                        text: "Not Done",
                        isActive: context.read<HomeCubit>().notDoneFilter,
                      ),
                      StatusComponent(
                        onTap: (){
                          context.read<HomeCubit>().onDoneFilterPressed();
                        },
                        height: 21.h,
                        width: 59.w,
                        text: "Done",
                        isActive: context.read<HomeCubit>().doneFilter,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: context.read<HomeCubit>().tasks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            context.read<HomeCubit>().onTaskPressed(index);
                            Scaffold.of(context).showBottomSheet((context) => const TaskButtomSheet(update: true,));
                          },
                          child: TaskContainer(
                            taskName: context.read<HomeCubit>().tasks[index].taskName!,
                            dueDate:
                            "${DateFormat("EEE").format(DateFormat("yyyy-MM-dd").parse(context.read<HomeCubit>().allTasks[index].dueDate!))} ${context.read<HomeCubit>().allTasks[index].dueDate!}",
                            hight: 100.h,
                            width: 323.w,
                            done: context.read<HomeCubit>().tasks[index].done!,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 53.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<HomeCubit>().initBottomSheet();
                          Scaffold.of(context).showBottomSheet((context) => const TaskButtomSheet());
                        },
                        style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xFF00CA5D),
                            ),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp)))),
                        child: Text(
                          "Create Task",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp
                          ),
                        ),
                      )),
                ],
              ),
                        ),
            );},
        ),
        // bottomSheet: BottomSheet(onClosing: () {  }, builder: (BuildContext context) {
        //   return CustomBottomSheet();
    );
  }
}
