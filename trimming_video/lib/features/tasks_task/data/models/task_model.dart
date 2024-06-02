import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.task_id,
    required super.status,
    required super.description,
    required super.created_at,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'task_id': task_id,
      'status': status,
      'description': description,
      'created_at': created_at.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      task_id: map['task_id'] as String,
      status: map['status'] as String,
      description: map['description'] as String,
      created_at: map['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['created_at']),
    );
  }

  factory TaskModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return TaskModel(
      task_id: data?["task_id"] ?? "",
      status: data?["status"] ?? "",
      description: data?["description"] ?? "",
      // created_at: DateTime.parse(data?["created_at"]),
      created_at: DateTime.now(),
    );
  }
}
