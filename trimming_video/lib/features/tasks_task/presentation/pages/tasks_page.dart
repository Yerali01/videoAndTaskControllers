import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trimming_video/core/theme/app_pallete.dart';
import 'package:trimming_video/core/utils/show_snackbar.dart';
import 'package:trimming_video/core/widgets/loader.dart';
import 'package:trimming_video/features/tasks_task/presentation/bloc/task_bloc_bloc.dart';
import 'package:trimming_video/features/tasks_task/presentation/pages/add_task_page.dart';
import 'package:trimming_video/features/tasks_task/presentation/widget/task_card.dart';

class TasksPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const TasksPage(),
      );
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBlocBloc>().add(TaskGetAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                AddTaskPage.route(),
              );
            },
            icon: const Icon(
              Icons.add_box_outlined,
            ),
          ),
        ],
      ),
      body: BlocConsumer<TaskBlocBloc, TaskBlocState>(
        listener: (context, state) {
          if (state is TaskFailure) {
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Loader();
          }
          if (state is TaskDisplaySuccess) {
            return Container(
              width: deviceWidth,
              height: deviceHeight,
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "You have",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        height: 0.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " ${state.deletedCount} ",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 0.5,
                          ),
                        ),
                        const TextSpan(
                          text: "deleted tasks",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 13),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return TaskCard(
                          task: task,
                          color: index % 3 == 0
                              ? AppPallete.gradient1
                              : index % 3 == 1
                                  ? AppPallete.gradient2
                                  : AppPallete.gradient3,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
