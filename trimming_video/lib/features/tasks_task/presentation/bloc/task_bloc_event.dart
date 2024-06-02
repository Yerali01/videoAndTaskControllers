part of 'task_bloc_bloc.dart';

@immutable
abstract class TaskBlocEvent {}

final class TaskUpload extends TaskBlocEvent {
  final String task_id;
  final String status;
  final String description;
  final DateTime created_at;

  TaskUpload({
    required this.task_id,
    required this.status,
    required this.description,
    required this.created_at,
  });
}

final class TaskGetAllTasks extends TaskBlocEvent {}
