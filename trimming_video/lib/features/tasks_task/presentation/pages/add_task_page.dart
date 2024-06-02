import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trimming_video/bottom_nav_bar_screen.dart';
import 'package:trimming_video/core/utils/show_snackbar.dart';
import 'package:trimming_video/core/widgets/loader.dart';
import 'package:trimming_video/features/tasks_task/presentation/bloc/task_bloc_bloc.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => AddTaskPage(),
      );
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

DateTime joiningDate = DateTime.now();
final TextEditingController _date = new TextEditingController();

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController descriptionController = TextEditingController();
  String? status;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void uploadTask() {
    if (descriptionController.text.isNotEmpty && status != null) {
      context.read<TaskBlocBloc>().add(
            TaskUpload(
              task_id: const Uuid().v1(),
              status: status!,
              description: descriptionController.text.trim(),
              created_at: DateTime.now(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new task"),
        centerTitle: true,
      ),
      body: BlocConsumer<TaskBlocBloc, TaskBlocState>(
        listener: (context, state) {
          if (state is TaskFailure) {
            showSnackbar(context, state.error);
          } else if (state is TaskUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BottomNavBarScreen.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Add some description",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is missing!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownMenu(
                  width: deviceWidth - 50,
                  label: const Text("Status"),
                  onSelected: (value) {
                    setState(() {
                      status = value.toString();
                    });
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "done", label: "Done"),
                    DropdownMenuEntry(
                        value: "in_progress", label: "In progress"),
                    DropdownMenuEntry(value: "failed", label: "Failed"),
                    DropdownMenuEntry(value: "deleted", label: "Deleted"),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(deviceWidth, 50),
                  ),
                  onPressed: () {
                    if (descriptionController.text.isNotEmpty &&
                        status != null) {
                      uploadTask();
                      showSnackbar(context, 'Задача опубликована');
                    } else {
                      showSnackbar(context, 'Заполните все поля');
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
