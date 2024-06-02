import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trimming_video/bottom_nav_bar_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trimming_video/features/init_dependencies.dart';
import 'package:trimming_video/features/tasks_task/presentation/bloc/task_bloc_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<TaskBlocBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video Trimmer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavBarScreen(),
      );
}
