import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trimming_video/core/usecase/usecase.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';
import 'package:trimming_video/features/tasks_task/domain/usecases/get_all_tasks.dart';
import 'package:trimming_video/features/tasks_task/domain/usecases/upload_task.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBlocBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  final UploadTask _uploadTask;
  final GetAllTasks _getAllTasks;
  TaskBlocBloc({
    required UploadTask uploadTask,
    required GetAllTasks getAllTasks,
  })  : _uploadTask = uploadTask,
        _getAllTasks = getAllTasks,
        super(TaskBlocInitial()) {
    on<TaskBlocEvent>((event, emit) => emit(TaskLoading()));
    on<TaskUpload>(_onTaskUpload);
    on<TaskGetAllTasks>(_onFetchAllTasks);
  }

  void _onTaskUpload(TaskUpload event, Emitter<TaskBlocState> emit) async {
    final res = await _uploadTask(
      UploadTaskParams(
        task_id: event.task_id,
        status: event.status,
        description: event.description,
        created_at: event.created_at,
      ),
    );

    res.fold(
      (l) => emit(TaskFailure(l.message)),
      (r) => emit(TaskUploadSuccess()),
    );
  }

  void _onFetchAllTasks(
    TaskGetAllTasks event,
    Emitter<TaskBlocState> emit,
  ) async {
    final res = await _getAllTasks(NoParams());

    int deletedCount = 0;

    res.fold(
        (l) => emit(
              TaskFailure(l.message),
            ), (r) {
      for (int i = 0; i < r.length; i++) {
        if (r[i].status == 'deleted') {
          deletedCount++;
          r.remove(r[i]);
        }
      }
      emit(
        TaskDisplaySuccess(r, deletedCount),
      );
    });
  }
}
