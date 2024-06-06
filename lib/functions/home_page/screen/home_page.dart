import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assessment/core/network_service.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_cubit.dart';
import 'package:technical_assessment/responsive/responsive_layout.dart';

import 'desktop_body.dart';
import 'mobile_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final homeCubit = context.read<HomeCubit>();
    NetworkService.listenNetwork(homeCubit);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileBody(),
        desktopBody: DesktopBody(),
      ),
    );
  }
}