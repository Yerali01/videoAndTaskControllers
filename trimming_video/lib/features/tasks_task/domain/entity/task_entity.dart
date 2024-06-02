class TaskEntity {
  final String task_id;
  final String status;
  final String description;
  final DateTime created_at;

  TaskEntity({
    required this.task_id,
    required this.status,
    required this.description,
    required this.created_at,
  });
}
