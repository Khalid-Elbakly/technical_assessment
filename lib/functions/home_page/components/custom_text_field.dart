import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  const CustomTextField({super.key, required this.hint,this.onTap, this.controller, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(0.5)),
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.sp)),
          fillColor: Color(0xFFD9D9D9).withOpacity(.4),
        ),
      ),
    );
  }
}
