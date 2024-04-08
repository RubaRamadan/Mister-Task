import 'package:flutter/material.dart';
import 'package:task_manager_app/Models/task.dart';
import 'package:task_manager_app/Widgets/reusable_task_card.dart';

class TasksListViewWidget extends StatelessWidget {
  const TasksListViewWidget({super.key, required this.tasksList});
final List<MyTask> tasksList;
  @override
  Widget build(BuildContext context) {
    return   Expanded(
        child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            var task =tasksList[index];
            return ReusableTaskCard(task: task,);
          },
        ));
  }
}
