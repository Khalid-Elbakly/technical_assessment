import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusComponent extends StatelessWidget {
  final String text;
  final bool isActive;
  final double width;
  final double height;
  final Function()? onTap;
  const StatusComponent({super.key, required this.text, required this.isActive, required this.width, required this.height, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00CA5D) : const Color(0xFF00CA5D).withOpacity(0.1)
              , borderRadius: BorderRadius.circular(10.sp)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Inter",
                color: isActive ? Colors.white : const Color(0xFF00CA5D),
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
