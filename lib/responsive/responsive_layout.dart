import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout(
      {super.key, required this.mobileBody, required this.desktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return ScreenUtilInit(
              designSize: const Size(360, 640), child: mobileBody);
        } else {
          return ScreenUtilInit(
              designSize: const Size(1280, 832), child: desktopBody);
        }
      },
    );
  }
}
