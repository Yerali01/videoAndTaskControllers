import 'package:fpdart/fpdart.dart';
import 'package:trimming_video/core/error/exceptions.dart';
import 'package:trimming_video/core/error/failures.dart';
import 'package:trimming_video/features/tasks_task/data/datasources/task_remote_data_source.dart';
import 'package:trimming_video/features/tasks_task/data/models/task_model.dart';
import 'package:trimming_video/features/tasks_task/domain/repository/task_repository.dart';
import '../../domain/entity/task_entity.dart';

class TaskRepositoryImplementation implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImplementation(this.taskRemoteDataSource);

  @override
  Future<Either<Failure, TaskEntity>> uploadTask({
    required String task_id,
    required String status,
    required String description,
    required DateTime created_at,
  }) async {
    try {
      TaskModel taskModel = TaskModel(
        task_id: task_id,
        status: status,
        description: description,
        created_at: created_at,
      );

      final uploadedTask = await taskRemoteDataSource.uploadTask(taskModel);
      return right(uploadedTask);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final tasks = await taskRemoteDataSource.getAllTasks();

      return right(tasks);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
