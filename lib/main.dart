import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:technical_assessment/core/hive/boxes_and_lists.dart';
import 'package:technical_assessment/functions/home_page/bloc/home_cubit.dart';
import 'package:technical_assessment/functions/home_page/screen/home_page.dart';
import 'core/hive/hive_task_model.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelHiveAdapter());
  AddBox = await Hive.openBox<TaskModelHive>('AddBox');
  UpdateBox = await Hive.openBox<TaskModelHive>('UpdateBox');
  DeleteBox = await Hive.openBox<TaskModelHive>('DeleteBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: MaterialApp(
      title: 'Technical Assessment',
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0)
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
            ),
    );
  }
}