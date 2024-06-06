import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_cubit.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_states.dart';
import 'package:technical_assessment/functions/home_page/components/status_component.dart';
import 'package:technical_assessment/functions/home_page/components/task_container.dart';
import 'package:technical_assessment/functions/home_page/components/task_dialog.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 70.w, right: 70.w, bottom: 17.h, top: 90.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Good Morning",
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
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
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            context.read<HomeCubit>().initBottomSheet();
                            showDialog(
                                context: context,
                                barrierColor: Color(0xCCFFFFFF),
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          side: BorderSide(
                                              strokeAlign: 1,
                                              style: BorderStyle.solid,
                                              color: Color(0xFF4ECB71)
                                                  .withOpacity(0.25),
                                              width: 4)),
                                      content: Form(
                                          key: context.read<HomeCubit>().formKey,
                                          child: TaskDialog()),
                                    ));
                          },
                          icon: Image.asset(
                            "images/add.png",
                            height: 60.h,
                            width: 60.w,
                          ))
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GridView.builder(
                        itemCount: context.read<HomeCubit>().tasks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InkWell(
                              onTap: () {
                                context.read<HomeCubit>().onTaskPressed(index);
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                            content: TaskDialog(
                                          update: true,
                                        )));
                              },
                              child: TaskContainer(
                                taskName: context
                                    .read<HomeCubit>()
                                    .tasks[index]
                                    .taskName!,
                                dueDate:
                                    "${DateFormat("EEE").format(DateFormat("dd-MM-yyyy").parse(context.read<HomeCubit>().tasks[index].dueDate!))} ${context.read<HomeCubit>().tasks[index].dueDate!}",
                                hight: 79.h,
                                width: 323.w,
                                done: context
                                    .read<HomeCubit>()
                                    .tasks[index]
                                    .done!,
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    MediaQuery.of(context).size.height *
                                    2),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      // bottomSheet: BottomSheet(onClosing: () {  }, builder: (BuildContext context) {
      //   return CustomBottomSheet();
    );
  }
}
