import 'package:fpdart/fpdart.dart';
import 'package:trimming_video/core/error/failures.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';

abstract interface class TaskRepository {
  Future<Either<Failure, TaskEntity>> uploadTask({
    required String task_id,
    required String status,
    required String description,
    required DateTime created_at,
  });

  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
}
