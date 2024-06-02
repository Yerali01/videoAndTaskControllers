import 'package:fpdart/fpdart.dart';
import 'package:trimming_video/core/error/failures.dart';
import 'package:trimming_video/core/usecase/usecase.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';
import 'package:trimming_video/features/tasks_task/domain/repository/task_repository.dart';

class UploadTask implements UseCase<TaskEntity, UploadTaskParams> {
  final TaskRepository taskRepository;
  UploadTask(this.taskRepository);

  @override
  Future<Either<Failure, TaskEntity>> call(UploadTaskParams params) async {
    return await taskRepository.uploadTask(
      task_id: params.task_id,
      status: params.status,
      description: params.description,
      created_at: params.created_at,
    );
  }
}

class UploadTaskParams {
  final String task_id;
  final String status;
  final String description;
  final DateTime created_at;

  UploadTaskParams({
    required this.task_id,
    required this.status,
    required this.description,
    required this.created_at,
  });
}
