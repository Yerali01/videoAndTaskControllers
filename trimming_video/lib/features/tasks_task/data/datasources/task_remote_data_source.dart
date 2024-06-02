import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trimming_video/core/error/exceptions.dart';
import 'package:trimming_video/features/tasks_task/data/models/task_model.dart';

abstract interface class TaskRemoteDataSource {
  Future<TaskModel> uploadTask(TaskModel task);

  Future<List<TaskModel>> getAllTasks();
}

class TaskRemoteDataSourceImplementation implements TaskRemoteDataSource {
  final FirebaseFirestore firebaseClient;

  TaskRemoteDataSourceImplementation(this.firebaseClient);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await FirebaseFirestore.instance.collection('tasks').get();
    final tasksData =
        snapshot.docs.map((e) => TaskModel.fromSnapshot(e)).toList();
    return tasksData;
  }

  @override
  Future<TaskModel> uploadTask(TaskModel task) async {
    try {
      final taskData = await FirebaseFirestore.instance
          .collection('tasks')
          .add(task.toJson());

      DocumentSnapshot taskInfo = await taskData.get();
      Map<String, dynamic> data = taskInfo.data() as Map<String, dynamic>;

      return TaskModel.fromJson(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
