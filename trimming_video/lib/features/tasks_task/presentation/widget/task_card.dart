import 'package:flutter/material.dart';
import 'package:trimming_video/core/utils/format_date.dart';
import 'package:trimming_video/features/tasks_task/domain/entity/task_entity.dart';

class TaskCard extends StatefulWidget {
  final TaskEntity task;
  final Color color;
  TaskCard({super.key, required this.task, required this.color});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      width: deviceWidth,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.status,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Task id: ${widget.task.task_id}",
          ),
          const SizedBox(height: 10),
          Text(
            widget.task.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 4,
          ),
          const Spacer(),
          Text(
            "${formatDateByDMMMYYYY(widget.task.created_at)}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
