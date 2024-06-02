import 'package:fpdart/fpdart.dart';
import 'package:trimming_video/core/error/failures.dart';
import 'package:trimming_video/core/usecase/usecase.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';
import 'package:trimming_video/features/tasks_task/domain/repository/task_repository.dart';

class GetAllTasks implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository taskRepository;
  GetAllTasks(this.taskRepository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await taskRepository.getAllTasks();
  }
}
