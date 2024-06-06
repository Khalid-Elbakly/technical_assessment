import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskContainer extends StatelessWidget {
  final bool done;
  final double width;
  final double hight;
  final String taskName;
  final String dueDate;
  const TaskContainer({super.key, required this.done, required this.width, required this.hight, required this.taskName, required this.dueDate,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Material(
        elevation: 5.sp,
        borderRadius: BorderRadius.circular(10.sp),
        child: Container(
          height: hight,
          width: width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 17.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      taskName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "Due Date: $dueDate",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                Image.asset("images/done.png",height: 37.h,width: 37.w,color: done ? null : Colors.grey.withOpacity(0.3),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
