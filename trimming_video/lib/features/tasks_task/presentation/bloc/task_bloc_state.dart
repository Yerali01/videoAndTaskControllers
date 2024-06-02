part of 'task_bloc_bloc.dart';

@immutable
abstract class TaskBlocState {}

class TaskBlocInitial extends TaskBlocState {}

final class TaskLoading extends TaskBlocState {}

final class TaskFailure extends TaskBlocState {
  final String error;
  TaskFailure(this.error);
}

final class TaskUploadSuccess extends TaskBlocState {}

final class TaskDisplaySuccess extends TaskBlocState {
  final List<TaskEntity> tasks;
  final int deletedCount;
  TaskDisplaySuccess(this.tasks, this.deletedCount);
}
