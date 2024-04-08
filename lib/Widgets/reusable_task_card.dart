import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Models/task.dart';

import '../Bloc/TaskBloc/tasks_bloc.dart';
import '../screens/Home/add_or_update_task_page.dart';

class ReusableTaskCard extends StatefulWidget {
  const ReusableTaskCard({super.key, required this.task});
  final MyTask task;
  @override
  State<ReusableTaskCard> createState() => _ReusableTaskCardState();
}

class _ReusableTaskCardState extends State<ReusableTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: widget.task.isChecked ? Colors.green : Colors.purple)),
      child: ListTile(
          title: Row(
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration:
                        widget.task.isChecked ? TextDecoration.lineThrough : null),
              ),
              Text(
                ' (${widget.task.manager})',
                style: TextStyle(
                    fontSize: 16,
                    decoration:
                        widget.task.isChecked ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
          subtitle: Text(widget.task.description,
              style: const TextStyle(
                fontSize: 16,
              )),
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddOrUpdateTaskPage(isUpdateTaskPage: true,task: widget.task),
                ));
          },
          trailing: widget.task.isChecked
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ))
              : IconButton(
                  onPressed: () {
                    BlocProvider.of<TasksBloc>(context).add(DoneTask(
                          task: widget.task,
                        ));
                  },
                  icon: const Icon(Icons.circle_outlined,
                      color: Colors.deepPurple))),
    );
  }
}
