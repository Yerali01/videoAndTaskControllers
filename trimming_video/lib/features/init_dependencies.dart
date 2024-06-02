import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:trimming_video/features/tasks_task/data/datasources/task_remote_data_source.dart';
import 'package:trimming_video/features/tasks_task/data/repositories/task_repositories_implementation.dart';
import 'package:trimming_video/features/tasks_task/domain/repository/task_repository.dart';
import 'package:trimming_video/features/tasks_task/domain/usecases/get_all_tasks.dart';
import 'package:trimming_video/features/tasks_task/domain/usecases/upload_task.dart';
import 'package:trimming_video/features/tasks_task/presentation/bloc/task_bloc_bloc.dart';

part 'init_dependencies.main.dart';
